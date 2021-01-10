#!/bin/sh -eux

if [ $# != 1 ]; then
    echo "usage: x.sh {app_prefix_name}"
    exit 1
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd ${SCRIPT_DIR}/functions/start
gcloud functions deploy ${1}-start \
--entry-point Start \
--runtime go113 \
--env-vars-file .env.yaml \
--trigger-http \
--region asia-northeast1

cd ${SCRIPT_DIR}/functions/stop
gcloud functions deploy ${1}-stop \
--entry-point Stop \
--runtime go113 \
--env-vars-file .env.yaml \
--trigger-http \
--region asia-northeast1 \

cd ${SCRIPT_DIR}/functions/autostop
gcloud functions deploy ${1}-autostop \
--entry-point Autostop \
--runtime go113 \
--env-vars-file .env.yaml \
--trigger-http \
--region asia-northeast1 \
