#!/usr/bin/env bash

. instance_id.sh
. instance_state.sh
. stop_instance.sh

profile=${1}
name=${2}


id=$(retrieve_id ${profile} ${name})
state=$(retrieve_state ${profile} ${name})

if [[ "${state}" == "running" ]]; then 
    stop $profile $name
fi