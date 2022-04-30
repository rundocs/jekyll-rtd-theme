# scheme

![CI](https://github.com/rundocs/jekyll-rtd-theme/workflows/CI/badge.svg?branch=develop)
![jsDelivr](https://data.jsdelivr.com/v1/package/gh/rundocs/jekyll-rtd-theme/badge)

This theme is inspired by [jekyll-rtd-theme](https://github.com/rundocs/jekyll-rtd-theme) acting as a [remote-theme](https://www.siteleaf.com/blog/remote-themes/) on our project pages that runs using the algorithm of [DNA Recombination](https://eq19.github.io).

[![DNA Animation](https://user-images.githubusercontent.com/36441664/87265280-9b985880-c4ec-11ea-8af1-403fe5648fc5.gif)](https://eq19.github.io)

![Twin Pairs](https://user-images.githubusercontent.com/36441664/73700083-28f2a800-4718-11ea-97b3-2e9a738dc09e.png)

[![Prime Hexagon](https://user-images.githubusercontent.com/36441664/74550123-6dd1d680-4f83-11ea-8810-3b8f4f50a9c0.png)](https://eq19.github.io/hexagon)

Each cycles will have a total of five (5) steps prime algorithm on base 114-31=83 that consist of three (3) leading steps by the power of 168: Q19(12, 32), Q17(33, 50), Q13(51, 68) and two (2) lagging steps by 618: Q7(69, 70), Q2(71, 83).

## What it does?

[![DNA Recombination](https://user-images.githubusercontent.com/36441664/88602920-fd84c080-d09d-11ea-970d-dd63c12221fc.png)](https://eq19.github.io)

![Recombination Steps](https://user-images.githubusercontent.com/36441664/84945702-c7a10380-b111-11ea-894a-ba31a23732a7.jpeg)

![Mutation](https://user-images.githubusercontent.com/36441664/84945494-89a3df80-b111-11ea-97d2-8d2597b315af.png)

## Quick start

```yml
remote_theme: rundocs/jekyll-rtd-theme
```

You can [generate](https://github.com/rundocs/starter-slim/generate) with the same files and folders from [rundocs/starter-slim](https://github.com/rundocs/starter-slim/)

## Usage

Documentation that can guide how to create with Github pages, please refer to [rundocs.io](https://rundocs.io) for details

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

mermaid:
  custom:     # mermaid link
  initialize: # this will prased to json, default: {}

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

## The license

The theme is available as open source under the terms of the MIT License
