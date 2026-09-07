# 安装说明（INSTALL）

本目录是 `evidence-based-engineering` 方法论的**单一权威源**。**没有安装脚本**——安装就是把对应文件放到各工具的加载位置；下面按「工具 × 系统」说清该放哪。

## 文件清单

| 文件 | 作用 | 目标工具 | 加载方式 |
|---|---|---|---|
| `SKILL.md` | 精华层（含 YAML frontmatter） | Qoder、Claude Code | 按需触发 |
| `reference.md` | 详情层（渐进披露） | Qoder、Claude Code | 按需展开 |
| `AGENTS.md` | 精简核心（自包含） | Codex 及其他读 `AGENTS.md` 的工具 | 始终加载 |
| `trae-rules.md` | 精简核心（自包含） | TRAE `project_rules.md` | 始终加载 |
| `README.md` | 项目主页（简介 + 跨工具用法） | — | — |
| `INSTALL.md` | 本文件 | — | — |
| `LICENSE` | 许可证 | — | — |

> Qoder 与 Claude Code 共用同一套 Agent Skills 规范，`SKILL.md` + `reference.md` **零改动**即可用于两者。
> Codex / TRAE 用「始终加载的指令文件」，因此单独提供**精简核心**，避免每次会话都吃满上下文。

## 放哪：工具 × 系统

`~` 表示当前用户的主目录：

- **Windows**：`C:\Users\<你>\`
- **macOS**：`/Users/<你>/`
- **Linux**：`/home/<你>/`

| 工具 | 放什么 | Windows | macOS / Linux |
|---|---|---|---|
| **Qoder** | 整个仓库 | `C:\Users\<你>\.qoder\skills\evidence-based-engineering\` | `~/.qoder/skills/evidence-based-engineering/` |
| **Claude Code** | `SKILL.md` + `reference.md` | `C:\Users\<你>\.claude\skills\evidence-based-engineering\` | `~/.claude/skills/evidence-based-engineering/` |
| **Codex** | `AGENTS.md` 的内容 | 项目级 `<项目>\AGENTS.md`；或全局 `C:\Users\<你>\.codex\AGENTS.md` | 项目级 `<项目>/AGENTS.md`；或全局 `~/.codex/AGENTS.md` |
| **TRAE** | `trae-rules.md` 的内容 | 项目级 `<项目>\.trae\rules\project_rules.md`；或 IDE 设置里的 user_rules | 项目级 `<项目>/.trae/rules/project_rules.md`；或 user_rules |

## 为什么这样分层

- **Qoder / Claude Code → 用户级全局**：二者是**按需触发**的 skill，放全局装一次即对所有项目生效，且不占用每次会话的上下文。
- **Codex / TRAE → 项目级**：二者的指令文件**始终加载**，放项目级可避免污染你在**所有**项目的每一次会话；确需全局再放 `~/.codex/AGENTS.md` 或 IDE 的 user_rules。

## 放置要点

- **Qoder**：本仓库自身即 skill 源——把它克隆 / 移动到上表路径即可，Qoder 自动识别并按需加载 `SKILL.md` + `reference.md`，无需再复制文件。
- **Claude Code**：在上表路径下新建 `evidence-based-engineering/` 目录，把 `SKILL.md`、`reference.md` 复制进去。
- **Codex / TRAE**：目标是**始终加载**的指令文件。若项目已存在 `AGENTS.md` / `project_rules.md`，请把精简核心**并入**而不是覆盖，以免冲掉你已有的规则。

## 维护约定

精简核心（`AGENTS.md` / `trae-rules.md`）是 `SKILL.md` 的浓缩副本。修改方法论时的顺序：

1. 先改权威源 `SKILL.md` / `reference.md`；
2. 同步更新两份精简核心；
3. 按上表把改动后的文件重新放到各工具的加载位置；
4. 用版本控制记录一次提交，保持可回滚。
