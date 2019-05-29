#!/bin/bash
set -e
while true; do
    inotifywait /root/.lnd/data/chain/bitcoin/$1/channel.backup
    aws s3 cp /root/.lnd/data/chain/bitcoin/$1/channel.backup s3://${BACKUP_BUCKET}/$1-channel.backup
done
