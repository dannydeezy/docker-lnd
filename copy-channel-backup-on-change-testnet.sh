#!/bin/bash
while true; do
    inotifywait /root/.lnd/data/chain/bitcoin/testnet/channel.backup
    aws s3 cp /root/.lnd/data/chain/bitcoin/testnet/channel.backup s3://${BACKUP_BUCKET}/testnet-channel.backup
done
