#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# licence       : BSD 3-Clause License
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_jvcl_::is_homebrew_installed() {
  local _bool=false
  if type brew &>/dev/null; then
    _bool=true
  elif _jvcl_::ask "Do you want to install Homebrew"; then
    _jvcl_::h3 "Installing Homebrew"
    curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
    _bool=true
  fi
  echo "${_bool}"
}

_jvcl_::brew_install_formula() {
  if [ "$(_jvcl_::is_homebrew_installed)" == true ]; then
    _jvcl_::h1 "Checking if ${1} is installed..."
    brew ls --versions "${1}" || brew install "${1}"
  fi
}

_jvcl_::generic_function() {
  local _bool=true
  if cmd; then _bool=false; fi
  echo _bool
}
