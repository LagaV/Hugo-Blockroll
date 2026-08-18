#!/usr/bin/env bash
set -euo pipefail

site_dir="${1:-.}"
source_file="$site_dir/static/blogroll.opml"
target_dir="$site_dir/public/.well-known"

if [[ ! -f "$source_file" ]]; then
  echo "Missing canonical OPML: $source_file" >&2
  exit 1
fi

mkdir -p "$target_dir"
cp "$source_file" "$target_dir/recommendations.opml"
echo "Published $target_dir/recommendations.opml"
