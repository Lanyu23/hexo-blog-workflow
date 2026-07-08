# AI Tool Note Workflow

Use for AI usage reflections, GitHub AI projects, Codex/Claude Code experience posts, and Vibe Coding lessons.

## Research

When the user provides a GitHub repo or tool link:

1. Read the README or official docs.
2. Extract what the project does, core components, setup/use flow, and the problem it solves.
3. Separate verified repo facts from the user's personal usage experience.
4. If the user says the final result is not known yet, write the post as an in-progress observation, not a final verdict.

## Frontmatter

Use category `AI 工具手记`.

Common tags:

```yaml
tags:
  - AI
  - Codex
  - Claude Code
  - Vibe Coding
  - Skills
  - 项目规范
  - 工具
  - 使用感受
```

Pick only relevant tags.

## Article Shape

Use this shape for GitHub tool/project posts:

```markdown
> 一句话：一句直接结论。

最近看到/发现一个项目：[owner/repo](URL)。

## 这个项目到底是干嘛的
## 为什么我觉得它有价值
## 我最看重的几个方向
## 使用中的感受
## 我的期待 / 我的结论
```

For pure experience posts without a repo, use:

```markdown
> 一句话：经验总结。

## 这次遇到的问题
## 最容易踩的坑
## 更好的做法
## 可以直接这样提示 AI
## 现在的结论
```

## Tone Rules

- Keep the user's examples concrete, including uncomfortable details such as token cost, permissions, failed debugging, or account cost.
- Avoid over-selling AI tools. Say "目前还在使用中" or "最终效果还要看成品" when appropriate.
- Preserve useful numbers, model names, token usage, and supplier names exactly when the user provides them.
- Make the post readable as a personal note first, tool introduction second.
