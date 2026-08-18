# Integration

## Generic Hugo theme

Call `{{ partial "blockroll/head.html" . }}` before `</head>`. Use `{{< blockroll >}}` on the human-readable page.

For RSS, add the Source namespace to the root element:

```xml
<rss version="2.0" xmlns:source="http://source.scripting.com/">
```

Then call `{{ partial "blockroll/rss.html" . }}` inside `<channel>`.

These two RSS edits are explicit because Hugo has no universal RSS-extension hook shared by every theme.

## PaperMod

In `layouts/partials/extend_head.html`:

```go-html-template
{{ partial "blockroll/head.html" . }}
```

Copy PaperMod's `layouts/_default/rss.xml` into the site-level `layouts/_default/rss.xml`, add the `xmlns:source` declaration, and call the RSS partial inside `<channel>`.

## Well-known endpoint

Run after every Hugo build:

```sh
path/to/Hugo-Blockroll/scripts/publish-well-known.sh path/to/site
```

This intentionally creates the alias only in `public/`; `static/blogroll.opml` remains the single maintained source.

## Identity semantics

Do not add `rel="me"` to blogroll entries. Use it only for a URL representing the same person or organization as the publishing site.
