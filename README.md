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

### 1. 克隆仓库（含所有子模块）

```bash
git clone --recurse-submodules https://github.com/dl-leo6688/agent-skills-library.git
```

### 2. 更新所有技能到最新

```bash
git submodule update --remote --recursive
```

---

## 🔒 安全审计

所有技能已通过 [NVIDIA SkillSpector](https://github.com/NVIDIA/SkillSpector) v2.3.13 静态扫描，**无真实恶意代码发现**。

---

## 📁 目录结构

```
agent-skills-library/
├── skills/
│   ├── anthropic-skills/           # 17 skills
│   ├── addyosmani-agent-skills/    # 24 skills
│   ├── context-engineering/        # 17 skills
│   ├── awesome-agent-skills/       # 1497+ index
│   └── vercel-skills-cli/          # CLI tool
├── tools/SkillSpector/             # Security scanner
└── reports/                        # Audit reports
```

---

## ⚠️ 已知冲突

- `obra/superpowers` 与 `addyosmani/agent-skills` 在工程生命周期上**严重冲突**，不可同时加载

---

## 📄 许可

MIT
