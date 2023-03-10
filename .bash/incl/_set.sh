#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#
# settings to write safe scripts
# <https://sipb.mit.edu/doc/safe-shell/>
#
# The Set Builtin allows you to change the values of shell options
# <https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html>
#
# Shopt builtin allows you to change additional shell optional behavior
# <https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html>
#
# The Unofficial Bash Strict Mode
# These lines deliberately cause your script to fail.
# Wait, what? Believe me, this is a good thing.
# <http://redsymbol.net/articles/unofficial-bash-strict-mode/>
#
# Safer bash scripts with 'set -euxo pipefail'
# <https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/>
#
#====================================================

_jvcl_::set_show_options() {
  bash --version || :
  cat <<EOF

Bash $(if [[ "${-}" =~ [eu] ]]; then echo "Strict Mode activated"; else echo "Options"; fi) set ${-}

$(echo ${SHELLOPTS} | tr ':' '\n')
$(shopt -s)

EOF
}

_jvcl_::set_terminal_mode() {
  set +eu
  set -E -o pipefail
  shopt -s failglob
  IFS=$'\n\t'
}

_jvcl_::set_strict_mode() {
  _jvcl_::set_terminal_mode
  set -eu
}

_jvcl_::set_terminal_mode
if [ "${BASH_STRICT_MODE}" -gt 0 ]; then
  _jvcl_::set_strict_mode
fi
