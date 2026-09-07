# 安装 / 分发说明（INSTALL）

本目录是 `evidence-based-engineering` 方法论的**单一权威源**，可分发到 Qoder / Claude Code / Codex / TRAE。

## 文件清单

| 文件 | 作用 | 目标工具 | 加载方式 |
|---|---|---|---|
| `SKILL.md` | 精华层（含 YAML frontmatter） | Qoder、Claude Code | 按需触发 |
| `reference.md` | 详情层（渐进披露） | Qoder、Claude Code | 按需展开 |
| `AGENTS.md` | 精简核心（自包含） | Codex 及其他读 `AGENTS.md` 的工具 | 始终加载 |
| `trae-rules.md` | 精简核心（自包含） | TRAE `project_rules.md` | 始终加载 |
| `install.ps1` | Windows 一键分发脚本 | — | — |
| `INSTALL.md` | 本文件 | — | — |

> Qoder 与 Claude Code 共用同一套 Agent Skills 规范，`SKILL.md` + `reference.md` **零改动**即可用于两者。
> Codex / TRAE 用「始终加载的指令文件」，因此单独提供**精简核心**，避免每次会话都吃满上下文。

## 层级策略（混合）

- **Claude Code / Qoder** → **用户级全局**（`~/.claude/skills/`、`~/.qoder/skills/`）。skill 按需触发，全局放置没有上下文负担。
- **Codex / TRAE** → **项目级**（`<project>/AGENTS.md`、`<project>/.trae/rules/project_rules.md`）。它们始终加载，放项目级可避免污染你在**所有**项目的每一次会话。

## 一键安装（Windows PowerShell）

在你需要使用的项目目录下运行（把 `<本目录>` 换成此技能目录的实际路径）：

```powershell
powershell -ExecutionPolicy Bypass -File "<本目录>\install.ps1" -Project "<你的项目路径>"
```

参数：

- `-Project <path>`：Codex / TRAE 指令文件的项目级目标（默认当前目录）
- `-SkipClaude` / `-SkipCodex` / `-SkipTrae`：跳过其中某一项

脚本行为（**安全优先**）：

- **Claude**：复制 `SKILL.md` + `reference.md` 到 `~/.claude/skills/evidence-based-engineering/`（覆盖，因为这是本技能的镜像目录）。
- **Codex**：目标 `AGENTS.md` 不存在则创建；**已存在则绝不覆盖**，改写旁文件 `AGENTS.evidence-based-engineering.md` 并提示手动合并。
- **TRAE**：目标 `.trae/rules/project_rules.md` 不存在则创建；**已存在则绝不覆盖**，改写旁文件并提示手动合并。

## 手动安装

- **Qoder**：本目录即 skill 源，无需操作。
- **Claude Code**：复制 `SKILL.md`、`reference.md` 到 `~/.claude/skills/evidence-based-engineering/`。
- **Codex**：把 `AGENTS.md` 内容并入项目根 `AGENTS.md`；若要全局生效，放到 `~/.codex/AGENTS.md`（注意它会影响你**所有**项目的 Codex 会话）。
- **TRAE**：把 `trae-rules.md` 内容并入项目的 `.trae/rules/project_rules.md`，或粘贴进 IDE 设置里的 user_rules（用户级规则优先级高于项目级）。

## 维护约定

精简核心（`AGENTS.md` / `trae-rules.md`）是 `SKILL.md` 的浓缩副本。修改方法论时的顺序：

1. 先改权威源 `SKILL.md` / `reference.md`；
2. 同步更新两份精简核心；
3. 重跑 `install.ps1` 分发；
4. 用版本控制记录一次提交，保持可回滚。
