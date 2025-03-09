#!/usr/bin/env bash
PROFILE=${1}
INSTANCE_NAME=${2}
RDS_NAME=${3}

# verify if the parameteres was inputed
if [[ -z ${PROFILE} || -z ${INSTANCE_NAME} || -z ${RDS_NAME} ]]; then
    echo "Primeiro argumento 'PROFILE' ou Segundo argumento 'INSTANCE_NAME' ou Terceiro argumento 'RDS_NAME' não foi informado"
    exit 1
fi

# try to get the intance id based on parameters
INSTANCE_ID=$(\
    aws --profile ${PROFILE} ec2 describe-instances \
    --filter "Name=tag:Name,Values=${INSTANCE_NAME}" \
    --query "Reservations[].Instances[?State.Name == 'running'].InstanceId[]" \
    --output text \
)

# verify if the instance id was found
if [[ -z ${INSTANCE_ID} ]]; then
    echo "Instância ${INSTANCE_NAME} não foi encontrada"
    exit 1
fi

# try to get the rds endpoint
RDS_DNS=$(\
    aws --profile ${PROFILE} rds describe-db-instances \
    --db-instacne-identifier ${RDS_NAME} \
    --query 'DBInstances[0].Endpoint.Address' \
    --output text \
)

# verify if the rds endpoins was found
if [[ -z ${RDS_DNS} ]]; then
    echo "Endpoit / DNS do RDS não foi identificado"
    exit 1
fi

# establish the rds tunnel
aws --profile ${PROFILE} ssm start-session \
    --target ${INSTANCE_ID} \
    --document-name AWS-StartPortForwardingSessionToRemoteHost \
    --parameters '{"host":["'${RDS_DNS}'"],"portNumber":["3001"],"localPortNumber":["3002"]}'

exit 0