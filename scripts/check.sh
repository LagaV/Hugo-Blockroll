#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
xmllint --noout "$repo_dir/exampleSite/static/blogroll.opml"
bash -n "$repo_dir/scripts/publish-well-known.sh"

if command -v hugo >/dev/null 2>&1; then
  output_dir="/tmp/hugo-blogroll-check"
  hugo --source "$repo_dir/exampleSite" --themesDir ../.. --theme Hugo-Blogroll --destination "$output_dir" --cleanDestinationDir
  grep -q 'class="blogroll-comment"' "$output_dir/blogroll/index.html"
  grep -q 'class="blogroll-favicon"' "$output_dir/blogroll/index.html"
  grep -q 'rel="blogroll"' "$output_dir/blogroll/index.html"
  grep -q 'class="xoxo blogroll"' "$output_dir/blogroll/index.html"
  grep -q 'xmlns:source="http://source.scripting.com/"' "$output_dir/index.xml"
  grep -q '<source:blogroll>https://example.org/blogroll.opml</source:blogroll>' "$output_dir/index.xml"
else
  echo "Hugo not installed; skipped example build."
fi
