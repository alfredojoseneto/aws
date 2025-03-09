#!/usr/bin/env bash

. scripts/instance_id.sh
. scripts/instance_state.sh
. scripts/stop_instance.sh
. scripts/start_instance.sh

profile=${1}
name=${2}


id=$(retrieve_id ${profile} ${name})
state=$(retrieve_state ${profile} ${name})

echo $id
echo $state

if [[ "${state}" == "stopped" ]]; then 
    start $profile $name
fi

if [[ "${state}" == "running" ]]; then 
    stop $profile $name
fi
