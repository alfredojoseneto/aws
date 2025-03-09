#!/usr/bin/env bash
retrieve_id(){
    profile="${1}"
    instance_name="${2}"
    id=$(\
        aws --profile "${profile}" ec2 describe-instances \
        --filter "Name=tag:Name,Values=${instance_name}" \
        --query "Reservations[].Instances[].InstanceId[]" \
        --output "text" \
    )
    echo "${id}"
}

