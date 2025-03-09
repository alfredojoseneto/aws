#!/usr/bin/env bash

# import scripts
. scripts/instance_id.sh

retrieve_state() {
    profile="${1}"
    instance_name="${2}"
    instance_id=$(retrieve_id "${profile}" "${instance_name}")
    state=$(\
        aws --profile formacao-aws ec2 describe-instances \
        --filter "Name=tag:Name,Values=bia-dev" \
        --query "Reservations[].Instances[?InstanceId=='"${instance_id}"'].State.Name" \
        --output text \
    )

    echo "${state}"

}