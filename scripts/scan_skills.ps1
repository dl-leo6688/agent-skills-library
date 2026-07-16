# SkillSpector scan script for agent-skills-library
param([switch]$WithLLM, [string]$OutputDir = "reports")
$ErrorActionPreference = "Continue"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path -Parent
$exe = "$root\tools\SkillSpector\.venv\Scripts\skillspector.exe"
$baseline = "$root\.skillspector-baseline.yaml"
$out = "$root\$OutputDir"
if (-not (Test-Path $out)) { New-Item -ItemType Directory -Path $out -Force | Out-Null }
$baseArgs = if ($WithLLM) { @() } else { @("--no-llm") }

Write-Host "Agent Skills Library - Security Audit" -ForegroundColor Cyan
Write-Host ""

$targets = @(
    @{N="anthropic-skills"; P="$root\skills\anthropic-skills\skills\"},
    @{N="addyosmani-agent-skills"; P="$root\skills\addyosmani-agent-skills\skills\"},
    @{N="context-engineering"; P="$root\skills\context-engineering\skills\"}
)

$results = @()
$start = Get-Date

foreach ($t in $targets) {
    if (-not (Test-Path $t.P)) {
        Write-Host "[SKIP] $($t.N): not found" -ForegroundColor Yellow
        continue
    }
    Write-Host ">>> Scanning $($t.N)..." -ForegroundColor Green
    $jf = "$out\report_$($t.N).json"
    $args = @("scan", $t.P, "--recursive", "--format", "json", "--output", $jf) + $baseArgs
    if (Test-Path $baseline) { $args += @("--baseline", $baseline) }
    $s = Get-Date
    $null = & $exe $args 2>&1
    $d = [math]::Round(((Get-Date) - $s).TotalSeconds, 1)
    if (Test-Path $jf) {
        try {
            $j = Get-Content $jf -Raw | ConvertFrom-Json
            if ($j.multi_skill) {
                $score = $j.max_risk_score
                $sev = "MULTI"
                $rec = if ($score -gt 50) { "DO_NOT_INSTALL" } elseif ($score -gt 20) { "CAUTION" } else { "SAFE" }
                $cnt = $j.skill_count
            } else {
                $score = $j.risk_assessment.score
                $sev = $j.risk_assessment.severity
                $rec = $j.risk_assessment.recommendation
                $cnt = $j.issues.Count
            }
            $c = if ($score -gt 50) { "Red" } elseif ($score -gt 20) { "Yellow" } else { "Green" }
            Write-Host "    Max Score: $score/100 | $rec | Skills: $cnt (${d}s)" -ForegroundColor $c
            $results += [PSCustomObject]@{Skill=$t.N; Score=$score; Rec=$rec; Skills=$cnt}
        } catch {
            Write-Host "    Parse error: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "    No output file (${d}s)" -ForegroundColor Yellow
    }
}

$dur = [math]::Round(((Get-Date) - $start).TotalSeconds, 1)
Write-Host ""
Write-Host "=== Summary (${dur}s) ===" -ForegroundColor Cyan
$results | Format-Table -AutoSize

$blocked = @($results | Where-Object { $_.Rec -eq "DO_NOT_INSTALL" }).Count
$warn = @($results | Where-Object { $_.Rec -eq "CAUTION" }).Count
$safe = @($results | Where-Object { $_.Rec -eq "SAFE" }).Count

Write-Host "SAFE: $safe | CAUTION: $warn | BLOCKED: $blocked"
if ($blocked -gt 0) {
    Write-Host "WARNING: $blocked skill pack(s) BLOCKED!" -ForegroundColor Red
    exit 1
} else {
    Write-Host "All skill packs passed security audit." -ForegroundColor Green
    exit 0
}
