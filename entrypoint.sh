#!/bin/bash

cd ${lndpackage} && ./lnd
cd /
npm install request
node lncli-unlock.js ${password}
