#!/bin/bash

docker build -t gcr.io/lightning-sandbox/lnd:0.1.5 .
docker push gcr.io/lightning-sandbox/lnd:0.1.5
