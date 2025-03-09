#!/usr/bin/env bash
PROFILE=${1}
INSTANCE_NAME=${2}

if [[ -z ${PROFILE} || -z ${INSTANCE_NAME} ]]; then
    echo ">[ERRO] Primeiro argumento 'PROFILE' ou Segundo argumento 'INSTANCE_NAME' não foi informado"
    exit 1
fi

INSTANCE_ID=$(\
    aws --profile ${PROFILE} ec2 describe-instances \
    --filter "Name=tag:Name,Values=${INSTANCE_NAME}" \
    --query "Reservations[].Instances[?State.Name == 'running'].InstanceId[]" \
    --output text \
)

if [[ -z ${INSTANCE_ID} ]]; then
    echo "Instância ${INSTANCE_NAME} não foi encontrada"
    exit 1
fi

aws --profile ${PROFILE} ssm start-session \
    --target ${INSTANCE_ID} \
    --document-name AWS-StartPortForwardingSession \
    --parameters '{"portNumber":["3001"],"localPortNumber":["3002"]}'

exit 0