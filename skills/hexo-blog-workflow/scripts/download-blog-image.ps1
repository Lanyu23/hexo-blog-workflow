param(
  [Parameter(Mandatory = $true)]
  [string]$Url,

  [Parameter(Mandatory = $true)]
  [string]$RelativePath,

  [string]$BlogRoot = $env:HEXO_BLOG_ROOT,

  [string]$Referer
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
$source = Join-Path $root "source"

if (-not (Test-Path -LiteralPath $source)) {
  New-Item -ItemType Directory -Force -Path $source | Out-Null
}

$normalized = $RelativePath.Replace("/", "\").TrimStart("\")
if (-not $normalized.StartsWith("img\", [StringComparison]::OrdinalIgnoreCase)) {
  throw "RelativePath must be under img/: $RelativePath"
}

$sourceFull = [IO.Path]::GetFullPath($source)
$sourcePrefix = $sourceFull.TrimEnd("\", "/") + [IO.Path]::DirectorySeparatorChar
$target = [IO.Path]::GetFullPath((Join-Path $source $normalized))

if (-not $target.StartsWith($sourcePrefix, [StringComparison]::OrdinalIgnoreCase)) {
  throw "RelativePath must stay under the Hexo source directory: $RelativePath"
}

$targetDir = Split-Path -Parent $target
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

$curlArgs = @(
  "-L",
  "--fail",
  "--silent",
  "--show-error",
  "--ssl-no-revoke",
  "--max-time", "60",
  "-A", "Mozilla/5.0"
)

if (-not [string]::IsNullOrWhiteSpace($Referer)) {
  $curlArgs += @("-e", $Referer)
}

$curlArgs += @("-o", $target, $Url)

& curl.exe @curlArgs
if ($LASTEXITCODE -ne 0) {
  throw "curl failed with exit code $LASTEXITCODE for $Url"
}

$file = Get-Item -LiteralPath $target
if ($file.Length -le 0) {
  throw "Downloaded file is empty: $target"
}

Write-Output "Downloaded: /$($normalized.Replace('\', '/')) ($($file.Length) bytes)"
