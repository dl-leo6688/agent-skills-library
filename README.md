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

---

## 🔌 激活到 VS Code Copilot

仓库下载后只是本地静态储备，需要挂载到 VS Code 才能被 Copilot 识别。

`setup.sh` 提供三种激活模式（在**目标工作区根目录**下执行）：

### 方案 A：链接工作区指令（最轻量）

将 `copilot-instructions.md` 链接到目标工作区的 `.github/`，Copilot 会读取技能索引但不自动加载技能文件。

```bash
bash setup.sh activate-a /path/to/your/workspace
```

### 方案 B：注册 58 个技能目录 ⭐推荐

将所有技能目录软链接到目标工作区的 `.github/skills/`，Copilot 按需加载每个技能的 `SKILL.md`。

```bash
bash setup.sh activate-b /path/to/your/workspace
```

### 方案 C：复制到用户级全局生效

复制技能到 `~/.claude/skills/`，所有工作区通用。

```bash
bash setup.sh activate-c
```

### 验证激活

```bash
ls .github/skills/ | wc -l   # 应输出 58
```

> 激活后建议重启 VS Code 或新开 Copilot Chat 会话。

---

## 🔒 安全审计

所有技能已通过 [NVIDIA SkillSpector](https://github.com/NVIDIA/SkillSpector) v2.3.13 静态扫描，**无真实恶意代码发现**。

---

## 📁 目录结构

```
agent-skills-library/
├── setup.sh                        # 🔧 安装 & 激活脚本
├── copilot-instructions.md         # 📋 Copilot 工作区指令
├── SKILLS_CATALOG.md               # 📖 58 个技能完整目录
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
