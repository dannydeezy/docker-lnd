#!/bin/bash

su -c "tor &" toruser
cp -r /.aws /root/.aws
/copy-channel-backup-on-change-testnet.sh &
/copy-channel-backup-on-change-mainnet.sh &
sleep 3
node /unlock-or-init.js &
./${lndpackage}/lnd
