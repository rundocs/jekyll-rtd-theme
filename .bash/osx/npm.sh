#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC1091
. ".bash/incl/all.sh"

_jvcl_::h1 "Checking if node is installed or install it with Homebrew"
brew ls --versions node || brew install node

_jvcl_::update_npm() {
  _jvcl_::h1 "Update Node.js packages..."
  npm install npm@latest --verbose
  npm update --save --verbose
  npm list --omit=dev
  npm list
}

_jvcl_::webpack() {
  npm run format
  npm run build
}

_jvcl_::update_sass() {
  rm -vrf _sass/lib && mkdir -pv _sass/lib

  mkdir -p _sass/lib/@primer/css
  mkdir -p _sass/lib/font-awesome
  mkdir -p _sass/lib/rouge
  mkdir -p _sass/lib/material-design-lite

  # @primer/css
  cp -r node_modules/@primer/css/support _sass/lib/@primer/css
  cp -r node_modules/@primer/css/base _sass/lib/@primer/css
  cp -r node_modules/@primer/css/breadcrumb _sass/lib/@primer/css
  cp -r node_modules/@primer/css/buttons _sass/lib/@primer/css
  cp -r node_modules/@primer/css/forms _sass/lib/@primer/css
  cp -r node_modules/@primer/css/loaders _sass/lib/@primer/css
  cp -r node_modules/@primer/css/markdown _sass/lib/@primer/css
  cp -r node_modules/@primer/css/utilities _sass/lib/@primer/css

  # font-awesome
  cp node_modules/font-awesome/scss/_variables.scss _sass/lib/font-awesome
  cp node_modules/font-awesome/scss/_icons.scss _sass/lib/font-awesome

  # rouge
  rougify style github | sass-convert --to scss >_sass/lib/rouge/github.scss

  # material-design-lite
  cp node_modules/material-design-lite/src/_color-definitions.scss _sass/lib/material-design-lite
  cp node_modules/material-design-lite/src/_functions.scss _sass/lib/material-design-lite
  cp node_modules/material-design-lite/src/_mixins.scss _sass/lib/material-design-lite
  cp node_modules/material-design-lite/src/_variables.scss _sass/lib/material-design-lite
}

_jvcl_::update_assets() {
  local _dest _asset _font

  for _asset in "jquery" "mermaid"; do
    _dest="assets/vendor/${_asset}@$(npm info "${_asset}" version)"
    mkdir -pv "${_dest}" && cp -vf "node_modules/${_asset}/dist/${_asset}.min.js" "${_dest}/${_asset}.min.js"
  done

  rm -vrf assets/fonts && mkdir -pv assets/fonts

  for _font in "lato-font" "roboto-fontface" "font-awesome"; do
    mkdir -pv "assets/fonts/${_font}"
  done

  # lato-font
  cp -pvr node_modules/lato-font/fonts/lato-bold/* assets/fonts/lato-font
  cp -pvr node_modules/lato-font/fonts/lato-bold-italic/* assets/fonts/lato-font
  cp -pvr node_modules/lato-font/fonts/lato-normal/* assets/fonts/lato-font
  cp -pvr node_modules/lato-font/fonts/lato-normal-italic/* assets/fonts/lato-font

  # roboto-fontface
  cp -pv node_modules/roboto-fontface/fonts/roboto-slab/Roboto-Slab-Bold.woff assets/fonts/roboto-fontface
  cp -pv node_modules/roboto-fontface/fonts/roboto-slab/Roboto-Slab-Bold.woff2 assets/fonts/roboto-fontface
  cp -pv node_modules/roboto-fontface/fonts/roboto-slab/Roboto-Slab-Regular.woff assets/fonts/roboto-fontface
  cp -pv node_modules/roboto-fontface/fonts/roboto-slab/Roboto-Slab-Regular.woff2 assets/fonts/roboto-fontface

  # font-awesome
  cp -pvr node_modules/font-awesome/fonts/* assets/fonts/font-awesome && rm -f assets/fonts/font-awesome/FontAwesome.otf
}

_jvcl_::update_npm
_jvcl_::update_sass
_jvcl_::update_assets
_jvcl_::webpack
