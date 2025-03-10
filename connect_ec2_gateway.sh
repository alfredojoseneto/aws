#!/usr/bin/env bash

# importing scripts
. scripts/instance_id.sh 
. scripts/instance_state.sh
. scripts/start_instance.sh
. scripts/stop_instance.sh
. scripts/tunnel_ec2.sh


# setting variables
profile=${1}
instance_name=${2}
local_port_number=3001
ec2_port_number=3001


# validating the inputed information
[[ -z "${profile}" || -z "${instance_name}" ]] && echo "Primeiro parâmetro 'PROFILE' ou segundo parâmetro 'INSTANCE_NAME' não foram informados" && exit 1


# retrive instance id
id=$(retrieve_id ${profile} ${instance_name})


# validate if the instance was founded
[[ -z "${id}" ]] && echo ">[ERRO] instância '${instance_name}' não encontrada" && exit 1


# retrive instance state
state=$(retrieve_state "${profile}" "${instance_name}")


# validate the instance state
[[ -z "${state}" ]] && echo "Instância ${instance_name} não encontrada" && exit 1


# verify the instance state to connect to it through ec2 tunnel
if [[ "${state}" != "running" ]]; then
    start "${profile}" "${instance_name}"
fi

echo "Instância EC2 ${instance_name} já está em execução"
echo "Estabelecendo tunnel com EC2 ${instance_name}"
tunnel_ec2 $profile $instance_name $local_port_number $ec2_port_number


exit 0

