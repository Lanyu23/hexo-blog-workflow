---
name: hexo-blog-workflow
description: Use when Codex needs to draft, preview, convert, publish, deploy, or troubleshoot posts in a Hexo blog, including source/_drafts, source/_posts, _config.yml, GitHub Pages, hexo generate/server/deploy, localized images, movie reviews, viewing logs, AI tool notes, or Chinese personal blog posts.
---

# Hexo Blog Workflow

## Core Context

- Work from the Hexo blog root: the directory containing `_config.yml`, `package.json`, and `source/`.
- Resolve the blog root from the user's explicit path first, then `HEXO_BLOG_ROOT`, then the current directory or its parents.
- Read `_config.yml` for the public `url`, permalink format, theme, and deploy target when they matter.
- Drafts live in `source/_drafts`; formal posts live in `source/_posts`.
- Use an available local preview port. Default to Hexo's `4000`; use another port such as `4002` when occupied or project docs prefer it.
- Do not deploy online unless the user explicitly asks to publish, upload, deploy, or verify the live site.

## Decision Tree

Read only the references needed for the current request:

- For any writing task, read `references/style-guide.md`.
- For movie, TV, anime, or viewing-log posts, read `references/movie-review.md`.
- For AI tools, GitHub project introductions, Vibe Coding lessons, or usage reflections, read `references/ai-tool-note.md`.
- For preview, draft-to-post conversion, deploy, or online verification, read `references/publish.md`.

## Default Workflow

1. Identify whether the user wants a draft/preview or an online publish.
2. If the user only gives raw notes, create a preview draft first.
3. Preserve the user's voice and language. Polish structure and clarity without making it corporate.
4. For online publish requests, resolve the exact target draft/post before converting. Prefer the slug/title just discussed, the browser's `preview/<slug>/`, or the single task-relevant non-demo draft.
5. Edit files with `apply_patch`; use UTF-8 when reading content in PowerShell.
6. Generate with `npx hexo generate --draft` for drafts or `npx hexo generate` for formal posts.
7. Start local preview only when useful: `npx hexo server --draft --port <port> --hostname localhost`.
8. Before deploying, stop any Hexo preview server that may lock `db.json`.
9. Deploy with the project's deploy command, usually `npm run deploy` or `npx hexo deploy`, then verify the final online URL returns HTTP 200.

## Useful Commands

Run from the Hexo blog root:

```powershell
npx hexo generate --draft
npx hexo server --draft --port 4000 --hostname localhost
npm run deploy
```

To convert one or more preview drafts into formal posts, use the bundled helper:

```powershell
powershell -ExecutionPolicy Bypass -File <skill-dir>\scripts\convert-draft-to-post.ps1 -BlogRoot <hexo-blog-root> -Slug slug-one slug-two
```

If running inside the Hexo blog root, `-BlogRoot` can be omitted.

To download an unreliable external image into local Hexo static assets, use:

```powershell
powershell -ExecutionPolicy Bypass -File <skill-dir>\scripts\download-blog-image.ps1 -BlogRoot <hexo-blog-root> -Url "IMAGE_URL" -RelativePath "img/post-slug/gallery-1.jpg"
```

## Safety Rules

- Do not publish to the live site unless the user explicitly asks for online publishing or deployment.
- Do not remove unrelated files or revert user changes.
- When converting drafts, remove preview-only `permalink: preview/...` so Hexo uses the site's normal permalink format.
- Localize images from anti-hotlink or unstable hosts before publishing.
- After deployment, report the final URLs and whether verification succeeded.
