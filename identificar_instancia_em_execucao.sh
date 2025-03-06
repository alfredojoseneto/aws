#!/usr/bin/env bash
PROFILE=${1}
INSTANCE_NAME=${2}

if [[ -z ${1} ]]; then
    echo "Primeiro argumento 'PROFILE' não foi informado"
fi

if [[ -z ${2} ]]; then
    echo "Segundo argumento 'INSTANCE_NAME' não foi informado"
fi

if [[ -z ${PROFILE} || -z ${INSTANCE_NAME} ]]; then
    exit 1
fi

INSTANCE_ID=$(\
    aws --profile ${PROFILE} ec2 describe-instances \
    --filter "Name=tag:Name,Values=${INSTANCE_NAME}" \
    --query "Reservations[].Instances[?State.Name == 'running'].InstanceId[]" \
    --output text \
)

if [[ -z ${INSTANCE_ID} ]]; then
    echo "Instância ${INSTANCE_NAME} não identificada"
    exit 1
fi

echo "Instância encontrada"
echo "PROFILE: ${PROFILE}"
echo "INSTANCE_NAME: ${INSTANCE_NAME}"
echo "INSTANCE_ID: ${INSTANCE_ID}"
