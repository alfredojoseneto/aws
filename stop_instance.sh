#!/usr/bin/env bash

# importing scripts
. instance_id.sh

stop() {

    profile="${1}"
    instance_name="${2}"
    instance_id=$(retrieve_id "${profile}" "${instance_name}")

    aws --profile "${profile}" ec2 stop-instances \
        --instance-ids "${instance_id}" > /dev/null
    
    echo "Instancia EC2 ${instance_name} com ID ${instance_id} sendo parada em 30 seg"
    for i in $(seq 1 30); do
        echo -n "."
        sleep 1
    done
    echo -e "\nParada concluída! Verificar console EC2 da AWS"

}