# Curso de Juniper JNCIA

Hola amigos este blog lo creo para facilitar el aprendisaje de Juniper Network - Este parte sera dedicada a Seguridad en su primera rama - JNCIA-SEC.

![juniper_logo](https://junipernetworks.allegiancetech.com/surveys/images/MRVCXM/juniper_logo.jpg)

# Capitulo 2 Security Certification Track

El programa de certificación de seguridad del Programa de certificación de Juniper Networks (JNCP) es un programa que permite a los participantes demostrar su competencia con la tecnología de Juniper Networks. Los candidatos seleccionados demuestran un conocimiento profundo de la tecnología de seguridad en general y del software Junos para dispositivos de la serie SRX.

## Ruta de certificación

La ruta de certificación de seguridad se muestra a continuación:

| Asociado | Especialista | Profesional  | Experto | 
| ------- | -------- |-------- |--------  |
| JNCIA-SEC | JNCIS-SEC  | JNCIP-SEC    | JNCIE-SEC  | 



## Hola mundo

```python
root> show version
```
> Validar la vesion del SRX

This theme is inspired by [sphinx-rtd-theme](https://github.com/readthedocs/sphinx_rtd_theme) and refactored with:

- [@primer/css](https://github.com/primer/css)
- [github-pages](https://github.com/github/pages-gem) ([dependency versions](https://pages.github.com/versions/))

## Linea de comandos

```yml
root>: show version
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

mermaid:
  custom: # mermaid link
  initialize: # mermaid options, default: {}

# also available via file: _include/assets/custom.scss
scss:

# also available via file: _include/assets/custom.js
script:

# also available via file: _data/translate.yml
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
validar la syntasis - [markdown](https://www.markdownguide.org/basic-syntax)
