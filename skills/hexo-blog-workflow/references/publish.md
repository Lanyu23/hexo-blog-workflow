# Preview And Publish Workflow

## Preview Draft

1. Write the draft to `source/_drafts/<slug>.md`.
2. Include `permalink: preview/<slug>/`.
3. Run from the Hexo blog root:

```powershell
npx hexo generate --draft
```

4. If a browser preview is useful, start:

```powershell
npx hexo server --draft --port <available-port> --hostname localhost
```

5. Give the user: `http://localhost:<available-port>/preview/<slug>/`.

## Convert Draft To Formal Post

Before converting, resolve the publish target:

- If the user names a slug/title, or just asked whether a specific draft is online, publish that draft when they say "upload", "publish", "deploy", "上传", or "发布到线上".
- If the browser URL is `preview/<slug>/`, publish that slug.
- If exactly one task-relevant non-demo draft exists, use it.
- If several task-relevant drafts could match, ask instead of guessing.
- Keep excluding `*demo*`, `*template*`, and old examples unless explicitly included.

Use the helper script for simple conversions:

```powershell
powershell -ExecutionPolicy Bypass -File <skill-dir>\scripts\convert-draft-to-post.ps1 -BlogRoot <hexo-blog-root> -Slug <slug>
```

It also accepts multiple slugs:

```powershell
powershell -ExecutionPolicy Bypass -File <skill-dir>\scripts\convert-draft-to-post.ps1 -BlogRoot <hexo-blog-root> -Slug slug-one slug-two slug-three
```

When already inside the Hexo blog root, `-BlogRoot` can be omitted.

Or do the same manually:

1. Move `source/_drafts/<slug>.md` to `source/_posts/<slug>.md`.
2. Remove `permalink: preview/<slug>/`.
3. Keep the original `date` unless the user asks to update it.

When the user says "all", list `source/_drafts` and publish only the task-relevant drafts. Exclude demo/template drafts such as `*demo*`, `*template*`, and old examples unless the user explicitly includes them.

## Deploy Online

1. Stop any local Hexo server that may be writing `db.json`.
2. Run the project's deploy command from the blog root:

```powershell
npm run deploy
```

If no deploy script exists, inspect `_config.yml` and use `npx hexo deploy` only when Hexo deploy is configured.

3. Derive final URLs from `_config.yml` `url` and the generated post permalink.
4. Verify final URLs:

```powershell
Invoke-WebRequest -UseBasicParsing -Uri "<public-post-url>" -TimeoutSec 20
```

5. Verify any newly localized images too, especially local `/img/...` assets.
6. If GitHub raw files return 200 but Pages returns 404, wait briefly and retry. GitHub Pages may lag after a successful push.

## Known Quirks

- If the default preview port is occupied, choose another port such as `4002`.
- Some Hexo source folders are not git repos because deployment happens through `.deploy_git`; check before relying on `git status`.
- Successful Hexo git deploy output often includes `Deploy done: git`.
- Bilibili/hdslb image URLs and some random CDNs can pass HEAD checks but render blank in browser because of anti-hotlinking. Localize them before publish.
