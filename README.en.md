# Hexo Blog Workflow Skill

Language: [中文](README.md) | English

A reusable Codex skill for drafting, previewing, converting, publishing, deploying, and troubleshooting Hexo blog posts.

## What It Covers

- Hexo drafts in `source/_drafts`
- Formal posts in `source/_posts`
- Preview URLs such as `preview/<slug>/`
- `npx hexo generate --draft`
- `npx hexo server`
- `npm run deploy` and `npx hexo deploy`
- Localizing unreliable external images into `source/img/...`
- Chinese personal blog posts, movie/viewing logs, and AI tool notes

The skill avoids project-specific paths and reads blog context from the user's Hexo root, `HEXO_BLOG_ROOT`, or the current working directory.

## Install

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

## Repository Layout

```text
skills/
  hexo-blog-workflow/
    SKILL.md
    agents/openai.yaml
    references/
    scripts/
```

## Notes

- The skill does not deploy online unless the user explicitly asks.
- Use `-BlogRoot`, `HEXO_BLOG_ROOT`, or run commands inside the Hexo blog root.
- The helper scripts are PowerShell scripts, so Windows users get the smoothest path. The written workflow itself is still useful on other systems.
