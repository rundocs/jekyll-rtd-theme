#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# shellcheck disable=SC2034
declare -i BASH_STRICT_MODE DEBUG

# shellcheck source=/dev/null
{
  . ".bash/settings.conf"
  . ".bash/incl/_set.sh"
  . ".bash/incl/_aliases.sh"
  . ".bash/incl/_colors.sh"
  . ".bash/incl/_debug.sh"
  . ".bash/incl/_homebrew.sh"
  # more files
}

_jvcl_::debug
