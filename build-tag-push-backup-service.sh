#!/bin/bash

docker build -t gcr.io/lightning-sandbox/backup-service-$1:$2 --build-arg network=$1 . -f Dockerfile-backup-service
docker push gcr.io/lightning-sandbox/backup-service-$1:$2
