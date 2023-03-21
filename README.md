# read-the-docs-jekyll-theme

![jsDelivr](https://data.jsdelivr.com/v1/package/gh/JV-conseil/read-the-docs-jekyll-theme/badge)
[![CodeQL](https://github.com/JV-conseil/read-the-docs-jekyll-theme/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/JV-conseil/read-the-docs-jekyll-theme/actions/workflows/github-code-scanning/codeql)
[![License EUPL 1.2](https://img.shields.io/badge/License-EUPL--1.2-blue.svg)](LICENSE)
[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil "Become a sponsor to JV-conseil")
[![Follow JV conseil on StackOverflow](https://img.shields.io/stackexchange/stackoverflow/r/2477854)](https://stackoverflow.com/users/2477854/jv-conseil "Follow JV conseil on StackOverflow")
[![Follow JVconseil on Twitter](https://img.shields.io/twitter/follow/JVconseil.svg?style=social&logo=twitter)](https://twitter.com/JVconseil "Follow JVconseil on Twitter")
[![Follow JVconseil on Mastodon](https://img.shields.io/mastodon/follow/109896584320509054?domain=https%3A%2F%2Ffosstodon.org)](https://fosstodon.org/@JVconseil "Follow JVconseil@fosstodon.org on Mastodon")
[![Follow JV conseil on GitHub](https://img.shields.io/github/followers/JV-conseil?label=JV-conseil&style=social)](https://github.com/JV-conseil "Follow JV-conseil on GitHub")

<!--
![CI](https://github.com/JV-conseil/read-the-docs-jekyll-theme/workflows/CI/badge.svg?branch=develop)
[![License BSD 3-Clause](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](LICENSE)
-->

> Read the Docs 📖 like Jekyll Theme for GitHub Pages

## What it does?

This theme is inspired by [sphinx-rtd-theme](https://github.com/read-the-docs-jekyll-theme/sphinx_rtd_theme) and refactored with:

- [@primer/css](https://github.com/primer/css)
- [github-pages](https://github.com/github/pages-gem) ([dependency versions](https://pages.github.com/versions/))

## Quick start

```yml
remote_theme: https://github.com/JV-conseil/read-the-docs-jekyll-theme
```

You can [generate][rundocs/starter] with the same files and folders from [rundocs/starter][rundocs/starter]

## Usage

Documentation that can guide how to create with Github pages, please refer to [rundocs/jekyll-rtd-theme](https://github.com/rundocs/jekyll-rtd-theme) for details

## Features

- Shortcodes (Toasts card, mermaid)
- Pages Plugins (emoji, gist, avatar, mentions)
- Auto generate sidebar
- [Attribute List Definitions](https://kramdown.gettalong.org/syntax.html#attribute-list-definitions) (Primer/css utilities, Font Awesome 4)
- Service worker (caches)
- SEO (404, robots.txt, sitemap.xml)
- Canonical Link (Open Graph, Twitter Card, Schema data)

## Options

| name          | default value        | description       |
| ------------- | -------------------- | ----------------- |
| `title`       | repo name            |                   |
| `description` | repo description     |                   |
| `url`         | user domain or cname |                   |
| `baseurl`     | repo name            |                   |
| `lang`        | `en`                 |                   |
| `direction`   | `auto`               | `ltr` or `rtl`    |
| `highlighter` | `rouge`              | Cannot be changed |

```yml
# folders sort
readme_index:
  with_frontmatter: true

meta:
  key1: value1
  key2: value2
  .
  .
  .

google:
  gtag:
  adsense:

mathjax: # this will prased to json, default: {}

# NOTE: mermaid custom link are no longer supported
# instead mermaid is updated to the lastest version
# available through cdn.jsdelivr.net
# mermaid:
#   custom:     # mermaid link
#   initialize: # this will prased to json, default: {}


scss:   # also _includes/extra/styles.scss
script: # also _includes/extra/script.js

translate:
  # shortcodes
  danger:
  note:
  tip:
  warning:
  # 404
  not_found:
  # copyright
  revision:
  # search
  searching:
  search:
  search_docs:
  search_results:
  search_results_found: # the "#" in this translate will replaced with results size!
  search_results_not_found:

plugins:
  - jemoji
  - jekyll-avatar
  - jekyll-mentions
```

## Sponsorship

If this project helps you, you can offer me a cup of coffee ☕️ :-)

[![Become a sponsor to JV-conseil](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=%23fe8e86)](https://github.com/sponsors/JV-conseil)

<!-- links -->

[rundocs/starter]: https://github.com/rundocs/starter
