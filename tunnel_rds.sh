#!/usr/bin/env bash

tunnel_rds() {

    profile="${1}"
    instance_name="${2}"
    ec2_port_number=${3}
    local_port_number=${4}

    rds_dns=$(\
        aws --profile "${profile}" rds describe-db-instances \
        --db-instance-identifier "${instance_name}" \
        --query 'DBInstances[0].Endpoint.Address' \
        --output text \
    )

    aws --profile ${profile} ssm start-session \
        --target ${instance_id} \
        --document-name AWS-StartPortForwardingSessionToRemoteHost \
        --parameters '{"host":["'${rds_dns}'"],"portNumber":["'${ec2_port_number}'"],"localPortNumber":["'${local_port_number}'"]}' #> /dev/null
        --parameters '{"host":["'${rds_dns}'"],"portNumber":["3001"],"localPortNumber":["3002"]}'

}