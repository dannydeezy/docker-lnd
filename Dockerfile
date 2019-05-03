FROM alpine

ENV lndpackage lnd-linux-amd64-v0.6-beta
ENV sha256sum ef37b3658fd864dfb3af6af29404d92337229378c24bfb78aa2010ede4cd06af

RUN apk --no-cache add wget tar bash nodejs nodejs-npm \
  && wget https://github.com/lightningnetwork/lnd/releases/download/v0.6-beta/${lndpackage}.tar.gz \
  && sha256sum ${lndpackage}.tar.gz \
  && echo "${sha256sum}  ${lndpackage}.tar.gz" > expected-sha256sum.txt \
  && sha256sum -c expected-sha256sum.txt

RUN tar xzvf ${lndpackage}.tar.gz

EXPOSE 8080 9735 10009
ADD ./package.json /package.json
RUN npm install

ADD ./entrypoint.sh /usr/local/bin/entrypoint.sh
ADD ./unlock-or-init.js /unlock-or-init.js

RUN chmod a+x /usr/local/bin/entrypoint.sh
RUN chmod a+x /unlock-or-init.js
RUN ln -s /${lndpackage} /lnd-main

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
