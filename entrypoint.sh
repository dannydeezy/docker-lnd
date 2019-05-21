#!/bin/bash

su -c "tor &" toruser
sleep 5
node /unlock-or-init.js &
./${lndpackage}/lnd
