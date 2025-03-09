#!/usr/bin/env bash

. instance_id.sh

tunnel_ec2() {
    profile="${1}"
    instance_name="${2}"
    ec2_port_number=${3}
    local_port_number=${4}
    instance_id=$(retrieve_id "${profile}" "${instance_name}")

    aws --profile ${profile} ssm start-session \
        --target ${instance_id} \
        --document-name AWS-StartPortForwardingSession \
        --parameters '{"portNumber":["'${ec2_port_number}'"],"localPortNumber":["'${local_port_number}'"]}' #> /dev/null
}
