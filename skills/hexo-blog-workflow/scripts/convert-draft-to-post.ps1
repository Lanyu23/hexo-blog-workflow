param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string[]]$Slug,

  [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
  [string[]]$AdditionalSlug,

  [string]$BlogRoot = $env:HEXO_BLOG_ROOT
)

$ErrorActionPreference = "Stop"

function Resolve-HexoBlogRoot {
  param([string]$Candidate)

  if (-not [string]::IsNullOrWhiteSpace($Candidate)) {
    $resolved = (Resolve-Path -LiteralPath $Candidate).Path
    if ((Test-Path -LiteralPath (Join-Path $resolved "_config.yml")) -and
        (Test-Path -LiteralPath (Join-Path $resolved "source"))) {
      return $resolved
    }
    throw "BlogRoot is not a Hexo blog root: $resolved"
  }

  $current = (Get-Location).Path
  while ($current) {
    if ((Test-Path -LiteralPath (Join-Path $current "_config.yml")) -and
        (Test-Path -LiteralPath (Join-Path $current "source"))) {
      return $current
    }

    $parent = Split-Path -Parent $current
    if ($parent -eq $current) {
      break
    }
    $current = $parent
  }

  throw "BlogRoot was not provided and the current directory is not inside a Hexo site. Pass -BlogRoot or set HEXO_BLOG_ROOT."
}

$root = Resolve-HexoBlogRoot -Candidate $BlogRoot
$drafts = Join-Path $root "source\_drafts"
$posts = Join-Path $root "source\_posts"

foreach ($dir in @($drafts, $posts)) {
  if (-not (Test-Path -LiteralPath $dir)) {
    throw "Missing blog directory: $dir"
  }
}

$slugs = foreach ($item in @($Slug) + @($AdditionalSlug)) {
  $item -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ }
}

foreach ($item in $slugs) {
  $name = [IO.Path]::GetFileName($item)
  if (-not $name.EndsWith(".md", [StringComparison]::OrdinalIgnoreCase)) {
    $name = "$name.md"
  }

  $from = Join-Path $drafts $name
  $to = Join-Path $posts $name

  if (-not (Test-Path -LiteralPath $from)) {
    throw "Draft not found: $from"
  }
  if (Test-Path -LiteralPath $to) {
    throw "Post already exists: $to"
  }

  $content = Get-Content -LiteralPath $from -Encoding UTF8 -Raw
  $content = [regex]::Replace($content, "(?m)^permalink:\s*preview\/[^\r\n]*\r?\n?", "")

  Set-Content -LiteralPath $from -Encoding UTF8 -NoNewline -Value $content
  Move-Item -LiteralPath $from -Destination $to

  Write-Output "Converted draft to post: $name"
}
