#!/bin/bash
while true; do
    inotifywait /root/.lnd/data/chain/bitcoin/mainnet/channel.backup
    aws s3 cp /root/.lnd/data/chain/bitcoin/mainnet/channel.backup s3://${BACKUP_BUCKET}/mainnet-channel.backup
done
