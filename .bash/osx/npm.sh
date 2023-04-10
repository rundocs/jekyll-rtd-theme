#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck source=/dev/null
. ".bash/incl/all.sh"

_jvcl_::update_npm() {
  _jvcl_::h1 "Update Node.js packages..."
  npm install npm@latest --verbose
  npm update --save --verbose
  npm list --omit=dev
  npm list
  _jvcl_::h1 "Npm audit..."
  npm audit || :
  npx depcheck --detailed || :
}

_jvcl_::webpack() {
  npm run format
  if [ "${DEBUG}" -gt 2 ]; then
    npm run dev
  else
    npm run build
  fi
}

_jvcl_::npm_package_version() {
  # shellcheck disable=SC2317
  npm info "${1%%/*}" version
}

_jvcl_::_sass_update() {
  local _asset _dest _pkg

  rm -vrf _sass/lib && mkdir -pv _sass/lib

  for _asset in "@primer/css/"{base,breadcrumb,buttons,forms,loaders,markdown,support,utilities} \
    "font-awesome/scss/"{_icons,_variables}.scss \
    "material-design-lite/src/"{_color-definitions,_functions,_mixins,_variables}.scss; do
    _pkg="${_asset%%/*}"
    # _dest="_sass/lib/${_pkg}@$(npm info "${_pkg/@primer/@primer/css}" version)"
    _dest="_sass/lib/${_pkg/@primer/@primer/css}"
    mkdir -pv "${_dest}" && cp -pvrf "node_modules/${_asset}" "${_dest}"
  done

}

_jvcl_::_sass_rougify() {
  local _folder="_sass/lib/rouge"
  mkdir -p "${_folder}"
  bundle exec rougify style github | bundle exec sass-convert --to scss >"${_folder}/github.scss"
}

_jvcl_::npm_package_version() {
  npm info "${1}" version
}

_jvcl_::update_assets() {
  local _asset _dest _pkg

  for _asset in "dompurify" "jquery"; do
    cp -pvf "node_modules/${_asset}/dist/"*.min.js "assets/lib/"
  done

  for _asset in "lato-font/fonts/lato-bold" \
    "lato-font/fonts/lato-bold-italic" \
    "lato-font/fonts/lato-normal" \
    "lato-font/fonts/lato-normal-italic" \
    "roboto-fontface/fonts/roboto-slab" \
    "font-awesome/fonts"; do

    _pkg="${_asset%%/*}"
    # _dest="assets/fonts/${_pkg}@$(npm info "${_pkg}" version)"
    _dest="assets/fonts/${_pkg}"

    mkdir -pv "${_dest}"
    cp -pvrf "node_modules/${_asset}/"*.{woff,woff2} "${_dest}"
    if [ "${_pkg}" == "font-awesome" ]; then
      cp -pvrf "node_modules/${_asset}/"*.{eot,svg,ttf} "${_dest}"
    fi
  done
}

if _jvcl_::brew_install_formula "node"; then
  _jvcl_::update_npm
  _jvcl_::_sass_update
  _jvcl_::_sass_rougify
  _jvcl_::update_assets
  _jvcl_::webpack
fi

# depecated

_jvcl_::_sass_update_v1() {
  local _asset _dest _pkg

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
