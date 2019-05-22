#!/bin/bash

docker build -t gcr.io/lightning-sandbox/lnd:$1 .
docker push gcr.io/lightning-sandbox/lnd:$1
