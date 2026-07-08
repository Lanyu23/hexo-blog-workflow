# Hexo Blog Workflow Skill

Language: [中文](#中文) | [English](#english)

## 中文

一个可复用的 Codex skill，用于在 Hexo 博客中起草、预览、转换、发布、部署和排查文章工作流。

### 覆盖内容

- `source/_drafts` 草稿
- `source/_posts` 正式文章
- `preview/<slug>/` 预览链接
- `npx hexo generate --draft`
- `npx hexo server`
- `npm run deploy` 和 `npx hexo deploy`
- 将不稳定的外部图片本地化到 `source/img/...`
- 中文个人博客、影评/观影记录、AI 工具手记

这个 skill 不绑定具体项目路径，会从用户指定的 Hexo 根目录、`HEXO_BLOG_ROOT`，或当前工作目录读取博客上下文。

### 安装

把 skill 文件夹复制到你的 Codex skills 目录。

Windows PowerShell:

```powershell
Copy-Item -Recurse -Force .\skills\hexo-blog-workflow "$env:USERPROFILE\.codex\skills\"
```

macOS/Linux:

```bash
cp -R skills/hexo-blog-workflow ~/.codex/skills/
```

然后让 Codex 使用 `$hexo-blog-workflow`。

### 仓库结构

```text
skills/
  hexo-blog-workflow/
    SKILL.md
    agents/openai.yaml
    references/
    scripts/
```

### 说明

- 除非用户明确要求线上发布或部署，否则 skill 不会执行 deploy。
- 使用 `-BlogRoot`、`HEXO_BLOG_ROOT`，或在 Hexo 博客根目录中运行命令。
- 辅助脚本是 PowerShell 脚本，所以 Windows 用户体验最顺；文字工作流本身在其他系统上也有参考价值。

## English

A reusable Codex skill for drafting, previewing, converting, publishing, deploying, and troubleshooting Hexo blog posts.

### What It Covers

- Hexo drafts in `source/_drafts`
- Formal posts in `source/_posts`
- Preview URLs such as `preview/<slug>/`
- `npx hexo generate --draft`
- `npx hexo server`
- `npm run deploy` and `npx hexo deploy`
- Localizing unreliable external images into `source/img/...`
- Chinese personal blog posts, movie/viewing logs, and AI tool notes

The skill avoids project-specific paths and reads blog context from the user's Hexo root, `HEXO_BLOG_ROOT`, or the current working directory.

### Install

Copy the skill folder into your Codex skills directory.

Windows PowerShell:

```powershell
Copy-Item -Recurse -Force .\skills\hexo-blog-workflow "$env:USERPROFILE\.codex\skills\"
```

macOS/Linux:

```bash
cp -R skills/hexo-blog-workflow ~/.codex/skills/
```

Then ask Codex to use `$hexo-blog-workflow`.

### Repository Layout

```text
skills/
  hexo-blog-workflow/
    SKILL.md
    agents/openai.yaml
    references/
    scripts/
```

### Notes

- The skill does not deploy online unless the user explicitly asks.
- Use `-BlogRoot`, `HEXO_BLOG_ROOT`, or run commands inside the Hexo blog root.
- The helper scripts are PowerShell scripts, so Windows users get the smoothest path. The written workflow itself is still useful on other systems.
