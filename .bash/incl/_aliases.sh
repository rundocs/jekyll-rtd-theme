#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
#
# author        : JV-conseil
# credits       : JV-conseil
# copyright     : Copyright (c) 2019-2023 JV-conseil
#                 All rights reserved
#====================================================

# export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad

# print environment variables sorted by name
# <https://stackoverflow.com/a/60756021/2477854>
alias env="env -0 | sort -z | tr '\0' '\n'"

alias ls='ls -FGlAhp --color=auto'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias nano="nano --linenumbers"
alias rm='rm -rf'

if ! [ -x "$(command -v cd_)" ]; then

  # Silent cd with no list directory
  cd_() { builtin cd "$@" || exit; }

  # Always list directory contents upon 'cd'
  cd() {
    builtin cd "$@" || exit
    ls
  }
fi
