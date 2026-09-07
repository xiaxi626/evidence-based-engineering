# Evidence-Based Engineering · 实证工程方法论

> 一个可跨 AI 编码工具复用的**工程方法论技能（Skill）与知识库**。核心只有一句：把「我认为」尽快变成「实测显示」。

![License](https://img.shields.io/badge/license-see%20LICENSE-blue)
![Tools](https://img.shields.io/badge/tools-Qoder%20%7C%20Claude%20Code%20%7C%20Codex%20%7C%20TRAE-green)

## 这是什么

这是一份在真实工程决策中被反复用过、并有实证结果的工作方法，被固化成 agent 可直接加载的 **Skill**，同时也能作为**知识库**供人查阅。

它不教你写代码，而是约束「下判断」的方式——让 agent（和你自己）在评审、验证、决策时，少犯那些**代价高昂又本可避免**的错误。

## 它解决什么问题

AI 辅助编码与工程协作里，真正的失败往往不是「不会写」，而是：

- 用「我逐条核对过了」代替真正跑一遍；
- 用「只要改几行」论证一个本不该做的改动；
- 悄悄改掉自己说错的结论，不留痕迹；
- 把软偏好当硬约束，为没有用户可见收益的事反复纠结（**钻牛角尖**）；
- 决定「不做」却无人记录，几周后又被重新提起。

本技能把这些教训固化为**可执行清单 + 判断尺子 + 反模式**，并用「规则分级」防止它自己退化成教条。

## 核心理念

> **一句话内核**：能跑的就必须跑，跑出来的就照实说，说错了就当场改并告诉依赖它的人，决定不做就写下理由和重开条件，改完就验证边界没被突破。

**它是默认工作法，不是审批关卡。** 每条规则分三档，执行强度不同：

| 档位 | 含义 | 执行强度 |
|---|---|---|
| `[护栏]` | 不做会导致数据损坏、错误结论或不可逆后果 | 默认强制 |
| `[默认]` | 有理由的默认选择，可被用户意图 / 项目约定覆盖 | 默认这样做 |
| `[审美]` | 收益是纯一致性 / 洁癖、用户观测不到差异 | 成本近零才顺手做 |

**优先级链**：`用户明确意图 > 项目既有约定 > 本技能默认 > 个人偏好`

## 支持的工具

一份权威源，适配四种工具的加载机制：

| 工具 | 机制 | 加载 | 使用的文件 |
|---|---|---|---|
| **Qoder** | Agent Skill | 按需触发 | `SKILL.md` + `reference.md` |
| **Claude Code** | Agent Skill | 按需触发 | `SKILL.md` + `reference.md` |
| **Codex** | `AGENTS.md` | 始终加载 | `AGENTS.md` |
| **TRAE** | Rules | 始终加载 | `trae-rules.md` |

> Qoder 与 Claude Code 共用 Agent Skills 规范，`SKILL.md` + `reference.md` **零改动**通用；Codex / TRAE 用「始终加载」的指令文件，故单独提供**精简核心**，以免每次会话都吃满上下文。

## 怎么用

**没有安装脚本**——把对应文件放到各工具的加载位置即可。`~` 表示用户主目录：Windows 是 `C:\Users\<你>\`，macOS 是 `/Users/<你>/`，Linux 是 `/home/<你>/`。

| 工具 | 放什么 | 放到哪 |
|---|---|---|
| **Qoder** | 整个仓库（它自身即 skill 源） | `~/.qoder/skills/evidence-based-engineering/` |
| **Claude Code** | `SKILL.md` + `reference.md` | `~/.claude/skills/evidence-based-engineering/` |
| **Codex** | `AGENTS.md` 的内容 | 项目级 `<项目>/AGENTS.md`；或全局 `~/.codex/AGENTS.md` |
| **TRAE** | `trae-rules.md` 的内容 | 项目级 `<项目>/.trae/rules/project_rules.md`；或 IDE user_rules |

- **Qoder / Claude Code** 是**按需触发**的 skill → 放**用户级全局**，装一次即对所有项目生效、不占上下文。Qoder 更省事：把本仓库直接放到 `~/.qoder/skills/` 下即可，它自身就是 skill 源，无需再复制文件。
- **Codex / TRAE** 的指令文件**始终加载** → 放**项目级**，避免污染所有会话；若项目已有 `AGENTS.md` / `project_rules.md`，请把精简核心**并入而非覆盖**。

> Windows 完整路径、分层理由与放置细节见 [INSTALL.md](INSTALL.md)。

## 仓库结构

```
evidence-based-engineering/
├── SKILL.md        # 精华层：元判据 + 七原则 + 四清单 + 决策尺子（Qoder/Claude，按需触发）
├── reference.md    # 详情层：完整原理、实证示例、反模式全表（渐进披露）
├── AGENTS.md       # 精简核心（Codex 等，始终加载）
├── trae-rules.md   # 精简核心（TRAE project_rules，始终加载）
├── INSTALL.md      # 各工具放置说明（放哪 / 为什么）
├── README.md       # 本文件
└── LICENSE
```

## 内容概览

- **七条核心原则**：实测优于推断 · 真实代码驱动验证 · 问题存在性优先 · 严重性与成本分开 · 最小化风险 · 自我校正与主动披露 · 决策闭环
- **四张操作清单**：评审候选任务 · 采纳「重写某函数」前 · 批量编辑文档 · 提交前
- **三条决策尺子**：严重性 > 成本 · 可达性按两条独立链路判定 · 缺陷测试自我标注
- **一条推导链**：外部评估 / 审计 → 逐条核实 → 过滤 → 收敛为最小任务 → 登记「不做的事项」

> 完整内容见 [SKILL.md](SKILL.md)（速查）与 [reference.md](reference.md)（详解）。

## License

详见 [LICENSE](LICENSE)。
