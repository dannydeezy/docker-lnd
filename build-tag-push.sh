#!/bin/bash

docker build -t gcr.io/lightning-sandbox/lnd:$1 . -f Dockerfile-lnd
docker push gcr.io/lightning-sandbox/lnd:$1
