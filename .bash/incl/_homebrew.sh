#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_jvcl_::is_homebrew_installed() {
  if type brew &>/dev/null; then
    true
  elif _jvcl_::ask "Do you want to install Homebrew"; then
    _jvcl_::h3 "Installing Homebrew"
    curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
    true
  else
    false
  fi
}

_jvcl_::brew_install_formula() {
  if _jvcl_::is_homebrew_installed; then
    _jvcl_::h1 "Checking if ${1} is installed..."
    brew ls --versions "${1}" || brew install "${1}"
  fi
}
