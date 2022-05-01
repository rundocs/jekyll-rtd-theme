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

![Tetractys](https://user-images.githubusercontent.com/36441664/85205823-ea1c6200-b347-11ea-8d6f-1ab3f9ec95c8.gif)

![Inner Hexagon](https://user-images.githubusercontent.com/36441664/83331599-55cb5c00-a2c1-11ea-833e-b14dd79b5f2d.jpg)

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

```
Scheme 13:9
===========
(1){1}-7:   7’
(1){8}-13:  6‘
(1)14-{19}: 6‘
------------- 6+6 -------
(2)20-24:   5’           |
(2)25-{29}: 5’           |
------------  5+5 -------
(3)30-36:   7:{70,30,10²}|
------------             |
(4)37-48:   12• ---      |
(5)49-59:   11°    |     |
            --}30° 30•   |
(6)60-78:   19°    |     |
(7)79-96:   18• ---      |
--------------           |
(8)97-109:  13           |
(9)110-139:{30}=5x6 <--x-- (129/17-139/27)
            --
           {43}

True Prime Vektors ζ(s):
(2,3), (29,89), (36,68), (72,42), (100,50), (2,3), (29,89), ...infinity

----------------------+-----+-----+-----+                                    ---
     7 --------- 1,2:1|   1 |  30 |  40 | 71 (2,3) ‹-------------@----        |
     |                +-----+-----+-----+-----+                        |      |
     |  8 ‹------  3:2|   1 |  30 |  40 |  90 | 161 (7) ‹---           |      5¨
     |  |             +-----+-----+-----+-----+             |          |      |
     |  |  6 ‹-- 4,6:3|   1 |  30 | 200 | 231 (10,11,12) ‹--|---       |      |
     |  |  |          +-----+-----+-----+-----+             |   |      |     ---
      --|--|-----» 7:4|   1 |  30 |  40 | 200 | 271 (13) --›    | {5®} |      |
        |  |          +-----+-----+-----+-----+                 |      |      |
         --|---› 8,9:5|   1 |  30 | 200 | 231 (14,15) ---------›       |      7¨
289        |          +-----+-----+-----+-----+-----+                  |      |
 |          ----› 10:6|  20 |   5 |  10 |  70 |  90 | 195 (19) --› Φ   | {6®} |
  --------------------+-----+-----+-----+-----+-----+                  |     ---
     67 --------› 11:7|   5 |   9 |  14 (20) --------› ¤               |      |
     |                +-----+-----+-----+                              |      |
     |  78 ‹----- 12:8|   9 |  60 |  40 | 109 (26) «------------       |     11¨
     |  |             +-----+-----+-----+                       |      |      |
     |  |  86‹--- 13:9|   9 |  60 |  69 (27) «-- Δ19 (Rep Fork) | {2®} |      |
     |  |  |          +-----+-----+-----+                       |      |     ---
     |  |   ---› 14:10|   9 |  60 |  40 | 109 (28) -------------       |      |
     |  |             +-----+-----+-----+                              |      |
     |   ---› 15,18:11|   1 |  30 |  40 | 71 (29,30,31,32) ----------        13¨
329  |                +-----+-----+-----+                                     |
  |   ‹--------- 19:12|  10 |  60 | {70} (36) ‹--------------------- Φ        |
   -------------------+-----+-----+                                          ---
    786 ‹------- 20:13|  90 |  90 (38) ‹-------------- ¤                      |
     |                +-----+-----+                                           |
     | 618 ‹- 21,22:14|   8 |  40 |  48 (40,41) ‹----------------------      17¨
     |  |             +-----+-----+-----+-----+-----+                  |      |
     |  | 594 ‹- 23:15|   8 |  40 |  70 |  60 | 100 | 278 (42) «--     |{6'®} |
     |  |  |          +-----+-----+-----+-----+-----+             |    |     ---
      --|--|-»24,27:16|   8 |  40 |  48 (43,44,45,46) ------------|----       |
        |  |          +-----+-----+                               |           |
         --|---› 28:17| 100 | {100} (50) ------------------------»           19¨
168        |          +-----+                                                 |
|         102 -› 29:18| 50  | 50(68) ---------> Δ18                           |
----------------------+-----+                                                ---
```

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
