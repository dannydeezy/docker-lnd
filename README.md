# docker-lnd
Docker for Lightning Network Daemon 

This Docker image runs Lnd with the following additional features:
- Automatic unlocking/wallet-creation script on startup
- Automatic channel backups to an Amazon S3 backup anytime the channel state changes
- Tor support

To enable Amazon S3 backups:
Create a folder called "aws" in the main directory and add your AWS credentials to this folder. This folder should contain two files: ```config``` and ```credentials```, in accordance with AWS standards. Do this before running the ```build-tag-push.sh``` script

To build, tag, and push the docker image to gcr.io/lightning-sandbox:
```
./build-tag-push.sh <tag>
```

Note
It is recommended to run this docker container using this helm chart: https://github.com/dannybitgo/lnd-chart
The Lnd config file is created in the helm chart's ```values.yaml``` file.
