#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
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
. ".bash/incl/all.sh"

_jvcl_::gem_update() {
  local _gem _gems=("bundler")
  for _gem in "${_gems[@]}"; do
    _jvcl_::h1 "Checking if ${_gem} is installed..."
    gem info "${_gem}" || gem install "${_gem}"
    gem update "${_gem}"
  done
}

_jvcl_::bundle_update() {
  local _opt
  for _opt in "check" "doctor" "install" "update" "lock"; do
    bundle "${_opt}" --verbose
  done
}

_jvcl_::jekyll_serve() {
  _jvcl_::h1 "Launching Jekyll..."
  bundle exec jekyll clean
  bundle exec jekyll doctor
  bundle exec jekyll serve --config "_config_dev.yml" --livereload
}

_jvcl_::github_pages() {
  bundle exec github-pages health-check
}

if _jvcl_::brew_install_formula "ruby"; then
  _jvcl_::gem_update
  _jvcl_::bundle_update
  _jvcl_::github_pages
  _jvcl_::jekyll_serve
fi
