# Hugo Blogroll

A reusable Hugo component that turns an extended OPML 2.0 subscription list into a human-readable, semantic blogroll.

It supports the [blogroll discovery conventions](https://opml.org/blogroll.opml):

- `/blogroll/` human-readable page
- `/blogroll.opml` OPML 2.0 document
- `<link rel="blogroll">` HTML discovery
- `<source:blogroll>` RSS discovery
- `/.well-known/recommendations.opml` conventional discovery URL
- XFN, h-card, XOXO, feed autodiscovery, categories, descriptions and modification dates
- optional `blogroll-comment` and `blogroll-logo-url` OPML attributes

## Requirements

- Hugo 0.149.0 or newer
- An OPML 2.0 file containing `text`, `xmlUrl`, and preferably `title` and `htmlUrl`

## Installation

Add this repository as a Hugo module or Git submodule. Until its GitHub URL is known, a local module mount can be used:

```toml
[[module.imports]]
path = "github.com/LagaV/Hugo-Blogroll"
```

Place the one canonical curator export at:

```text
static/blogroll.opml
```

Create `content/blogroll/index.md`:

```md
---
title: Blogroll
---

{{</* blogroll */>}}
```

Add the discovery and stylesheet partial inside your theme's `<head>`:

```go-html-template
{{ partial "blogroll/head.html" . }}
```

Add the RSS namespace to the root `<rss>` element:

```xml
xmlns:source="http://source.scripting.com/"
```

Then add this inside `<channel>`:

```go-html-template
{{ partial "blogroll/rss.html" . }}
```

After Hugo builds, publish the well-known alias:

```sh
./themes/Hugo-Blogroll/scripts/publish-well-known.sh .
```

See [docs/integration.md](docs/integration.md) for PaperMod and generic-theme examples.

## Configuration

All options are optional:

```toml
[params.blogroll]
opmlPath = "static/blogroll.opml"
publicURL = "/blogroll.opml"
showFavicons = true
showComments = true
showDescriptions = true
showUpdated = true
friendRel = true
```

The shortcode accepts the same display options as named arguments; named arguments override site configuration:

```md
{{</* blogroll showFavicons=false showComments=true */>}}
```

## Extended OPML attributes

Hugo Blogroll preserves and serves the OPML unchanged. Unknown attributes are ignored by normal OPML readers. The renderer understands:

- `blogroll-comment` — personal recommendation/comment, preferred over `description`
- `blogroll-logo-url` — HTTP(S) favicon or logo URL
- `blogroll-country`
- `blogroll-reachable`
- `blogroll-checked-at`

The last three remain machine-readable metadata and are not displayed by default.

## Single-source workflow

`static/blogroll.opml` is the only maintained OPML source. Hugo publishes it as `/blogroll.opml`; `publish-well-known.sh` copies it into the generated `public/.well-known/` directory. Do not maintain a second source copy.

## License

MIT
