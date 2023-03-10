#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# Jekyll on macOS
# <https://jekyllrb.com/docs/installation/macos/>
#
# bundle add github-pages --group "jekyll_plugins"
# bundle add jekyll-avatar
# bundle add jekyll webrick faraday-retry --group "development"
#
#====================================================

# shellcheck disable=SC1091
{
  . ".bash/incl/all.sh"
  . ".bash/osx/gem.sh"
}

_jvcl_::jekyll_serve() {
  _jvcl_::h1 "Launching Jekyll..."
  bundle exec jekyll clean --config "_config_dev.yml"
  bundle exec jekyll doctor --config "_config_dev.yml"
  bundle exec jekyll serve --config "_config_dev.yml" --livereload
}

_jvcl_::github_pages() {
  bundle exec github-pages health-check
}

# End sourced section
# What is the bash equivalent to Python's `if __name__ == '__main__'`?
# <https://stackoverflow.com/a/46004518/2477854>
return 2>/dev/null

# shellcheck disable=SC2317
if _jvcl_::brew_install_formula "ruby"; then
  _jvcl_::gem_update
  _jvcl_::bundle_update
  _jvcl_::github_pages
  _jvcl_::jekyll_serve
fi
