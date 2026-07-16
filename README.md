# 🧰 Agent Skills Library

> 个人 AI Agent Skills 整合库，精选顶级技能包，经安全审计，持续更新。

[![Skills Count](https://img.shields.io/badge/Skills-58-blue)](https://github.com/dl-leo6688/agent-skills-library)
[![Security Audited](https://img.shields.io/badge/Security-SkillSpector%20v2.3.13-green)](https://github.com/NVIDIA/SkillSpector)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## 📦 已整合的技能包

### 核心技能（方案 A）

| 技能包 | 来源 | ⭐ | 技能数 | 专长领域 |
|--------|------|:---:|:---:|------|
| **Anthropic Skills** | [anthropics/skills](https://github.com/anthropics/skills) | 161k | 17 | 文档(docx/pdf/pptx/xlsx)、创意生成、MCP 构建、网页测试 |
| **AddyOsmani Agent Skills** | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | 78.5k | 24 | **主开发方法论**：需求→规划→构建→测试→审查→发布 |
| **Context Engineering** | [muratcankoylan](https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering) | 17.2k | 17 | 上下文工程、多智能体架构、记忆系统、评估框架 |

### 辅助资源

| 资源 | 来源 | ⭐ | 说明 |
|------|------|:---:|------|
| **Awesome Agent Skills** | [VoltAgent](https://github.com/VoltAgent/awesome-agent-skills) | 28.1k | 📋 1497+ 官方/社区 skill 索引 |
| **Vercel Skills CLI** | [vercel-labs/skills](https://github.com/vercel-labs/skills) | 26.2k | 🔧 `npx skills` 管理工具 |

### 安全工具

| 工具 | 来源 | 说明 |
|------|------|------|
| **SkillSpector** | [NVIDIA/SkillSpector](https://github.com/NVIDIA/SkillSpector) | 🛡️ Skill 安全扫描器，已审计全部 58 个技能 |

---

## 🚀 快速开始

### 1. 克隆仓库

```bash
git clone https://github.com/dl-leo6688/agent-skills-library.git
cd agent-skills-library
```

### 2. 下载所有技能包

```bash
bash setup.sh install
```

> 此脚本会克隆全部 6 个子仓库到 `skills/` 和 `tools/` 目录。

### 3. 更新所有技能到最新

```bash
bash setup.sh update
```

更新后审计：
```powershell
.\scripts\scan_skills.ps1
```

> 💡 `git pull`（本仓库自身更新）会通过 `post-merge` hook 自动触发安全扫描。

---

## 🔒 安全审计

所有技能已通过 [NVIDIA SkillSpector](https://github.com/NVIDIA/SkillSpector) v2.3.13 静态扫描，**无真实恶意代码发现**。

### 快速扫描

```powershell
# 扫描所有技能包
.\scripts\scan_skills.ps1

# 查看误报基线
cat .skillspector-baseline.yaml
```

### 安全门禁

| 评分 | 建议 | 操作 |
|------|------|------|
| SAFE (0-20) | 通过 | ✅ 自动加载 |
| CAUTION (21-50) | 警告 | ⚠️ 人工审查 |
| DO_NOT_INSTALL (>50) | 阻止 | 🚫 禁止加载 |

### 新增第三方技能流程

```powershell
# 1. 扫描
uv run --project tools/SkillSpector skillspector scan ./new-skill/ --no-llm --baseline .skillspector-baseline.yaml

# 2. 如果通过，加入安全基线
uv run --project tools/SkillSpector skillspector baseline ./new-skill/ --no-llm -o .skillspector-baseline.yaml

# 3. 在 copilot-instructions.md 中注册
```

---

## 📁 目录结构

```
agent-skills-library/
<<<<<<< HEAD
├── setup.sh                        # 🔧 安装 & 激活脚本
├── copilot-instructions.md         # 📋 Copilot 工作区指令
├── SKILLS_CATALOG.md               # 📖 58 个技能完整目录
=======
├── .skillspector-baseline.yaml     # 误报基线（安全扫描用）
├── scripts/
│   └── scan_skills.ps1             # 批量安全扫描脚本
>>>>>>> e605fa2 (feat: SkillSpector 安全审计深度集成)
├── skills/
│   ├── anthropic-skills/           # 17 skills (an-- 前缀)
│   ├── addyosmani-agent-skills/    # 24 skills (addy-- 前缀)
│   ├── context-engineering/        # 17 skills (ctx-- 前缀)
│   ├── awesome-agent-skills/       # 1497+ index
│   └── vercel-skills-cli/          # CLI tool
├── tools/SkillSpector/             # 🛡️ Security scanner
└── reports/                        # 📊 Audit reports
```

### 技能前缀说明

激活时为避免不同技能包间的同名冲突，每个技能会加来源前缀：

| 前缀 | 来源 | 示例 |
|------|------|------|
| `an--` | Anthropic | `an--docx`, `an--pdf` |
| `addy--` | AddyOsmani | `addy--test-driven-development` |
| `ctx--` | Context Engineering | `ctx--memory-systems` |

---

## ⚠️ 已知冲突

- `obra/superpowers` 与 `addyosmani/agent-skills` 在工程生命周期上**严重冲突**，不可同时加载

---

## 📄 许可

MIT
