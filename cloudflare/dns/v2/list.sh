#!/bin/bash

# Check if exactly two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <PROD_ENV> <ENV>"
    exit 1
fi

export PROD_ENV=$1
export ENV=$2
export ZONE_ID="your-zone-id"


# Fetching external IPs for services and setting them as environment variables
REDIS_SERVICE_0_DNS_NAME=$(kubectl get svc $PROD_ENV-redis-service-0-$ENV -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export REDIS_SERVICE_0_DNS_NAME

REDIS_SERVICE_1_DNS_NAME=$(kubectl get svc $PROD_ENV-redis-service-1-$ENV -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export REDIS_SERVICE_1_DNS_NAME

REDIS_SERVICE_2_DNS_NAME=$(kubectl get svc $PROD_ENV-redis-service-2-$ENV -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export REDIS_SERVICE_2_DNS_NAME

REDIS_SENTINEL_SERVICE_0_DNS_NAME=$(kubectl get svc $PROD_ENV-redis-sentinel-service-0-$ENV -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export REDIS_SENTINEL_SERVICE_0_DNS_NAME

REDIS_SENTINEL_SERVICE_1_DNS_NAME=$(kubectl get svc $PROD_ENV-redis-sentinel-service-1-$ENV -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export REDIS_SENTINEL_SERVICE_1_DNS_NAME

REDIS_SENTINEL_SERVICE_2_DNS_NAME=$(kubectl get svc $PROD_ENV-redis-sentinel-service-2-$ENV -o=jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export REDIS_SENTINEL_SERVICE_2_DNS_NAME

# Echo the variables for confirmation
echo "REDIS_SERVICE_0_DNS_NAME=$REDIS_SERVICE_0_DNS_NAME"
echo "REDIS_SERVICE_1_DNS_NAME=$REDIS_SERVICE_1_DNS_NAME"
echo "REDIS_SERVICE_2_DNS_NAME=$REDIS_SERVICE_2_DNS_NAME"
echo "REDIS_SENTINEL_SERVICE_0_DNS_NAME=$REDIS_SENTINEL_SERVICE_0_DNS_NAME"
echo "REDIS_SENTINEL_SERVICE_1_DNS_NAME=$REDIS_SENTINEL_SERVICE_1_DNS_NAME"
echo "REDIS_SENTINEL_SERVICE_2_DNS_NAME=$REDIS_SENTINEL_SERVICE_2_DNS_NAME"

envsubst < env/main.tf.tpl > env/main.tf
