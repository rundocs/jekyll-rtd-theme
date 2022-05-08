---
myId: 87
to: 2
from: 1
weight: 2
category: user
init: external
flow: internal
event: property
label:  Optimasi
tag_name: ubuntu
run_time: /bin/python
value: [449,0,1,2]
pairs: [1,30,1,70,30,10]
tags: [5,8,13,15,19]
---
#!{{ page.run_time }}

#Unmark the 2 line below to see all commands available
#echo -e "\n$hr\nPATH COMMANDS\n$hr"
#compgen -c | xargs which -a | sort && dpkg -l

#Collumn numbers
COL=130
case $HOME in
    /root) COL=140;;
    /builder/home) COL=180;;
esac

printf -v res %${COL}s
export hr=`printf '%s\n' "${res// /-}"`
export hrd=`printf '%s\n' "${res// /=}"`

#Set Environtment
export WORKSPACE=$(realpath .)
export PATH=$HOME/.local/bin:$PATH

if [[ -n "${GITHUB_REPOSITORY+set}" ]]
then 
    [[ -z $TAG_NAME ]] && export TAG_NAME=ubuntu
    [[ -z $REPO_NAME ]] && export REPO_NAME=${GITHUB_REPOSITORY##*/}
    [[ -z $REPO_OWNER ]] && export REPO_OWNER=${GITHUB_REPOSITORY%/*}
    [[ -z $BRANCH_NAME ]] && export BRANCH_NAME=$(basename $(git name-rev --name-only HEAD))
    [[ -z $PROJECT_ID ]] && export PROJECT_ID=$(echo "$REPO_OWNER" | tr '[:upper:]' '[:lower:]')
fi

#Set the path to output volume
( [[ -n "${TAG_REPO+set}" ]] && [[ "$REPO_NAME" == "github_"* ]] ) && export REPO_NAME=$TAG_REPO
[[ -n "${RUNNER_WORKSPACE+set}" ]] && export OUTPUTS_VOLUME=$RUNNER_WORKSPACE/outputs/volume
[[ -n "${BUILDER_OUTPUT+set}" ]] && export OUTPUTS_VOLUME=/builder/outputs/volume
[[ -z "${OUTPUTS_VOLUME}" ]] && export OUTPUTS_VOLUME=$RWORKSPACE/outputs
[[ -z "${DEBIAN_FRONTEND}" ]] && export DEBIAN_FRONTEND=noninteractive
[[ -n "${INVOCATION_ID+set}" ]] && export BUILD_ID=${INVOCATION_ID}
[[ ! -d $OUTPUTS_VOLUME ]] && mkdir -p $OUTPUTS_VOLUME
