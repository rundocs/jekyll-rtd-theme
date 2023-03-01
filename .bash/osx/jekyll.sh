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
#====================================================

# shellcheck disable=SC1091
. ".bash/incl/all.sh"

_jvcl_::h1 "Checking if ruby is installed..."
brew ls --versions ruby || brew install ruby

_jvcl_::gem_update() {
  local _gem _gems=("bundler")
  for _gem in "${_gems[@]}"; do
    _jvcl_::h1 "Checking if ${_gem} is installed..."
    gem info "${_gem}" || gem install "${_gem}"
    gem update "${_gem}"
  done
}

_jvcl_::bundle_doctor() {
  local _opt
  for _opt in "install" "update" "doctor" "clean" "lock"; do
    bundle "${_opt}" --verbose
  done
}

_jvcl_::jekyll_serve() {
  _jvcl_::h1 "Launching jekyll..."
  jekyll clean
  jekyll doctor
  bundle exec jekyll serve --livereload
}

_jvcl_::github_pages() {
  bundle exec github-pages health-check
}

_jvcl_::gem_update
_jvcl_::bundle_doctor
_jvcl_::github_pages
_jvcl_::jekyll_serve
