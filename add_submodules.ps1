# agent-skills-library 子模块添加脚本
# 用法: 在终端中 cd 到 agent-skills-library 目录后，运行此脚本
#   cd D:\Github_scripts\agent-skills-library
#   .\add_submodules.ps1
# 注意: 网络较慢 (~40 KiB/s)，预计总耗时约 15-30 分钟

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# 配置 SSH keepalive 防止超时断开
$env:GIT_SSH_COMMAND = "ssh -o ServerAliveInterval=60 -o ServerAliveCountMax=3"

Write-Host "=== 当前已添加的子模块 ===" -ForegroundColor Green
git submodule status

Write-Host ""
Write-Host "=== 添加 context-engineering (浅克隆) ===" -ForegroundColor Yellow
git submodule add --depth 1 git@github.com:muratcankoylan/Agent-Skills-for-Context-Engineering.git skills/context-engineering

Write-Host ""
Write-Host "=== 添加 awesome-agent-skills (浅克隆) ===" -ForegroundColor Yellow
git submodule add --depth 1 git@github.com:VoltAgent/awesome-agent-skills.git skills/awesome-agent-skills

Write-Host ""
Write-Host "=== 添加 vercel-skills-cli (浅克隆) ===" -ForegroundColor Yellow
git submodule add --depth 1 git@github.com:vercel-labs/skills.git skills/vercel-skills-cli

Write-Host ""
Write-Host "=== 添加 SkillSpector (浅克隆) ===" -ForegroundColor Yellow
git submodule add --depth 1 git@github.com:NVIDIA/SkillSpector.git tools/SkillSpector

Write-Host ""
Write-Host "=== 全部添加完成! ===" -ForegroundColor Green
Write-Host ""
Write-Host "=== 最终子模块状态 ===" -ForegroundColor Green
git submodule status

Write-Host ""
Write-Host "=== .gitmodules 内容 ===" -ForegroundColor Green
Get-Content .gitmodules

Write-Host ""
Write-Host "接下来运行以下命令提交并推送:" -ForegroundColor Cyan
Write-Host "  git add -A"
Write-Host '  git commit -m "chore: add all skill submodules (6 total)"'
Write-Host "  git push"
