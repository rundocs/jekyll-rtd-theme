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

_jvcl_::h1 "Update Node.js packages..."

npm install npm@latest --verbose
npm update --save --verbose
npm list --omit=dev
npm list
