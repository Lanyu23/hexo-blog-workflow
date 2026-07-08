# Movie Review Workflow

Use for films, TV dramas, anime, and viewing records.

## Research

When the user gives only a title and impressions:

1. Research basic metadata online: original title, year, director/creator, country, genre, runtime/episodes, main cast.
2. Prefer reliable public sources. TMDB image URLs are acceptable for posters and backdrops when available.
3. Use the user's rating if supplied. If they give a range, preserve the range or choose a natural value only when they ask.
4. Avoid inventing details. If metadata is uncertain, omit the field or use a conservative phrasing.

## Frontmatter

Use category `影视记录`.

```yaml
movie_name: "片名"
original_name: "原名"
year: "年份"
director: "导演"
country: "地区"
genre: "类型"
watched_date: "YYYY-MM-DD"
rating: "评分"
spoiler: true
```

Use a landscape image for `index_img` and `banner_img` when available. If no landscape image exists, use a poster.

## Article Structure

Use this shape unless the user asks otherwise:

```markdown
> 一句话：一句自然短评。

## 基本信息

<div class="movie-info-grid">
  <figure class="movie-poster">
    <img src="POSTER_URL" alt="《片名》电影海报">
    <figcaption>电影海报</figcaption>
  </figure>

  <table class="movie-meta-table">
    <tbody>
      <tr><th>片名</th><td>片名</td></tr>
      ...
    </tbody>
  </table>
</div>

## 推荐程度
## 无剧透短评
## 我喜欢的地方
## 我没那么喜欢的地方
## 印象深刻
## 剧透感想
## 图片记录
```

## Image Rules

- In `基本信息`, always include a poster beside the metadata when a poster can be found.
- In `图片记录`, prefer landscape posters/backdrops. If not enough, use landscape scene stills.
- Aim for at least 3 landscape images. If fewer than 3 exist, use the maximum available.
- Remove duplicate or visually identical images.
- Treat "URL is 200" as insufficient. Verify images render through the local preview page or request the final local/static URL.
- Download images from Bilibili/hdslb, MAL, wiki thumbnails, random CDNs, or any source that may block hotlinking into `source/img/anime/<slug>/`, then reference `/img/anime/<slug>/<file>.jpg`.
- Use the bundled `scripts/download-blog-image.ps1` for localizing external images. Pass `-Referer` when a host requires it. This avoids missing banners and blank galleries caused by anti-hotlinking.
- Keep gallery spacing handled by existing `css/movie.css`; do not add inline spacing unless necessary.
- Use this gallery shape:

```html
<div class="movie-gallery">
  <figure class="movie-gallery-item">
    <img src="IMAGE_URL" alt="《片名》横屏剧照">
    <figcaption>横屏剧情截图 1</figcaption>
  </figure>
</div>
```

## Local Image Pattern

For unreliable image hosts, store assets like:

```text
source/img/anime/<slug>/poster.jpg
source/img/anime/<slug>/gallery-1.jpg
source/img/anime/<slug>/gallery-2.jpg
source/img/anime/<slug>/gallery-3.jpg
```

Reference them in Markdown as:

```yaml
index_img: /img/anime/<slug>/gallery-1.jpg
banner_img: /img/anime/<slug>/gallery-1.jpg
```

```html
<img src="/img/anime/<slug>/gallery-1.jpg" alt="《片名》横屏剧照">
```

After `npx hexo generate --draft`, verify:

```powershell
Invoke-WebRequest -UseBasicParsing -Uri "http://localhost:<preview-port>/img/anime/<slug>/gallery-1.jpg"
```
