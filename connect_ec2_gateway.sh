#!/usr/bin/env bash

# importing scripts
. instance_id.sh 
. instance_state.sh
. start_instance.sh
. stop_instance.sh
. tunnel_ec2.sh


# setting variables
profile=${1}
instance_name=${2}
local_port_number=3001
ec2_port_number=3001


# validating the inputed information
if [[ -z "${profile}" || -z "${instance_name}" ]]; then
    echo "Primeiro parâmetro 'PROFILE' ou segundo parâmetro 'INSTANCE_NAME' não foram informados"
    exit 1
fi


# retrive instance id
id=$(retrieve_id ${profile} ${instance_name})


# validate if the instance was founded
[[ -z "${id}" ]] && echo ">[ERRO] instância '${instance_name}' não encontrada" && exit 1


# retrive instance state
state=$(retrieve_state "${profile}" "${instance_name}")


# validate the instance state
[[ -z "${state}" ]] && echo "Instância ${instance_name} não encontrada"


# verificando se a instância já está em execução
if [[ "${state}" == "running" ]]; then
    echo "Instância EC2 ${instance_name} já está em execução"
    echo "Estabelecendo tunnel com EC2 ${instance_name}"
    tunnel_ec2 $profile $instance_name $local_port_number $ec2_port_number
fi


exit 0

