#!/bin/bash

docker build -t gcr.io/lightning-sandbox/unlocker:$1 . -f Dockerfile-unlocker
docker push gcr.io/lightning-sandbox/unlocker:$1
