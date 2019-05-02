const fs = require('fs');
const request = require('request');
function s(x) {return x.charCodeAt(0);}
const requestBody = {
  wallet_password: process.argv[2].split('').map(s)
};
const options = {
  url: 'https://localhost:8080/v1/unlockwallet',
  // Work-around for self-signed certificates.
  rejectUnauthorized: false,
  json: true,
  form: JSON.stringify(requestBody),
};
const unlock = () => {
  console.log('Attempting to unlock wallet');
  request.post(options, function(error, response, body) {
    console.log(body);
  });
}
setTimeout(unlock, 3000);
