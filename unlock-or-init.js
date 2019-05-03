/**
 * This script creates a wallet if none exists, and unlocks the wallet if it does exist
 * We determine if a wallet exists by checking if a password.txt file exists at /root/password.txt
 * In order for LND to run properly, this script must be invoked when the container starts
 *
 * After this script is run, the following files will exist:
 * /root/password.txt
 * /root/mnemonic.txt
 */

const fs = require('fs');
const request = require('request');
const passwordFile = '/root/password.txt';
const mnemonicFile = '/root/mnemonic.txt';
function convertToBytes(x) {return x.charCodeAt(0);}
let password, endpoint;

if (fs.existsSync(passwordFile)) {
  password = fs.readFileSync(passwordFile).toString();
  endpoint = 'unlockwallet';
} else {
  password = Math.random()*100000000000000000 + '' + Math.random()*100000000000000000;
  fs.writeFileSync(passwordFile, password);
  endpoint = 'initwallet';
}

const requestBody = {
  wallet_password: password.split('').map(convertToBytes)
};

const getOptions = (endpoint) => {
  return {
    url: 'https://localhost:8080/v1/' + endpoint,
    rejectUnauthorized: false,
    json: true
  };
}

const makeRequest = () => {
  console.log('Attempting to ' + endpoint);
  const options = getOptions(endpoint);
  options.form = JSON.stringify(requestBody);
  request.post(options, function(error, response, body) {
    console.log(body);
  });
}

const genSeedThenInit = () => {
  const options = getOptions('genseed');
  console.log('Attempting to generate seed');
  request.get(options, function(error, response, body) {
    requestBody.cipher_seed_mnemonic = body.cipher_seed_mnemonic;
    fs.writeFileSync(mnemonicFile, JSON.stringify(body.cipher_seed_mnemonic));
    makeRequest();
  });
}

if (endpoint === 'initwallet') {
  setTimeout(genSeedThenInit, 3000);
} else {
  setTimeout(makeRequest, 3000);
}
