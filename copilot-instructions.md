# Copilot Instructions

## 子代理 (Subagent) 模型配置

当使用 `runSubagent` 工具调用任何子代理时，**必须**显式指定 `model` 参数为 `"DeepSeek-V4-pro (copilot)"`。

---

## 已加载的 Agent Skills（方案 A）

本工作区加载了以下 skill 组合，请作为基础能力使用：

### 核心技能包（自动激活）

| 目录 | 来源 | ⭐ | 专长领域 |
|------|------|:---:|------|
| `skills/anthropic-skills/skills/` | anthropics/skills | 161k | 文档(docx/pdf/pptx/xlsx)、创意生成(art/design)、MCP 构建、网页测试 |
| `skills/addyosmani-agent-skills/skills/` | addyosmani/agent-skills | 78.5k | **主开发方法论**：需求→规划→构建→测试→审查→发布（24 技能） |
| `skills/context-engineering/skills/` | muratcankoylan/Agent-Skills-for-Context-Engineering | 17.2k | 上下文工程、多智能体架构、记忆系统、评估框架（17 技能） |

### 辅助资源（非技能包，按需查阅）

| 目录 | 来源 | ⭐ | 说明 |
|------|------|:---:|------|
| `skills/awesome-agent-skills/` | VoltAgent/awesome-agent-skills | 28.1k | 📋 **精选目录**：1497+ 官方/社区 skill 索引，用于发现新技能 |
| `skills/vercel-skills-cli/` | vercel-labs/skills | 26.2k | 🔧 **管理工具**：`npx skills` CLI，用于安装/更新/管理 skill |

---

## Skill 冲突检查规则（永久）

每次加载新的 skill 时，**必须先检查**与以上已加载 skill 之间是否存在冲突：

1. 读取新 skill 的 SKILL.md，提取其覆盖的领域和工作流
2. 与已加载的核心技能包做重叠矩阵分析：🟢互补 / 🟡部分重叠 / 🔴严重冲突
3. 如有 🔴 严重冲突（同名同功能、互斥方法论、生命周期同阶段竞争），告知用户并建议二选一
4. 告知用户后再执行操作

### 已知冲突
- `obra/superpowers` 与 `addyosmani/agent-skills` 在工程生命周期上严重冲突，**不可同时加载**

---

## 更新命令

```bash
git submodule update --remote --recursive && git add -A && git commit -m "chore: update skills" && git push
```
