# Style Guide

## Voice

- Write in the user's language unless the blog's existing posts clearly use another language.
- Preserve the user's direct voice, opinions, and examples. Clarify and structure; do not make the post corporate.
- Prefer readable personal-blog sections over marketing copy.
- Use short sections when they help scanning.
- Match existing posts for title style, category names, tags, and image conventions.

## Categories And Tags

- Inspect nearby posts before inventing categories or tags.
- Reuse the site's established taxonomy when possible.
- For Chinese personal blogs, natural categories such as `AI 工具手记` or `影视记录` are fine when they already fit the site.

## Common Frontmatter

```yaml
---
title: 标题
date: YYYY-MM-DD HH:mm:ss
categories:
  - 分类
tags:
  - 标签
index_img: /img/default.png
banner_img: /img/default.png
permalink: preview/example-slug/
---
```

For preview drafts, include `permalink: preview/<slug>/`.
For formal posts, remove the preview `permalink` line unless the user explicitly wants a custom permalink.

## Drafting Rules

- If the user asks to write or draft a post without asking for an online publish, create a preview draft under `source/_drafts`.
- If the user asks to publish online, move the draft to `source/_posts`, remove preview permalink, deploy, and verify.
- For online links, derive the base URL from `_config.yml` `url` and the final generated permalink.
