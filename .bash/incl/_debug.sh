#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# license       : EUPL-1.2 license
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

_jvcl_::debug() {
  if [[ "${DEBUG}" -eq 0 ]]; then
    return
  fi
  cat <<EOF


===============
 DEBUG LEVEL ${DEBUG}
===============

EOF

  cat /proc/version &>/dev/null
  cat /etc/issue &>/dev/null
  bash --version
  python --version

  if [[ "${DEBUG}" -gt 1 ]]; then

    if [[ "${DEBUG}" -gt 2 ]]; then

      echo "$(
        set -o posix
        set | sort
      )"

    else

      echo
      env
      echo

    fi

    echo
    alias
  fi

}
