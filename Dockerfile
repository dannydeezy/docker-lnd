FROM alpine

ENV lndpackage lnd-linux-amd64-v0.6-beta
ENV sha256sum ef37b3658fd864dfb3af6af29404d92337229378c24bfb78aa2010ede4cd06af
ENV BACKUP_BUCKET danny-lightning-test

RUN apk --no-cache add wget tar bash nodejs nodejs-npm tor inotify-tools py-pip \
  && wget https://github.com/lightningnetwork/lnd/releases/download/v0.6-beta/${lndpackage}.tar.gz \
  && sha256sum ${lndpackage}.tar.gz \
  && echo "${sha256sum}  ${lndpackage}.tar.gz" > expected-sha256sum.txt \
  && sha256sum -c expected-sha256sum.txt

RUN tar xzvf ${lndpackage}.tar.gz

RUN adduser -D -u 1000 toruser

EXPOSE 8080 9735 10009
ADD ./package.json /package.json
RUN npm install

ADD ./entrypoint.sh /usr/local/bin/entrypoint.sh
ADD ./unlock-or-init.js /unlock-or-init.js
ADD ./torrc /etc/tor/torrc
ADD ./copy-channel-backup-on-change-testnet.sh /copy-channel-backup-on-change-testnet.sh
ADD ./copy-channel-backup-on-change-mainnet.sh /copy-channel-backup-on-change-mainnet.sh

RUN pip install awscli
ADD ./aws /.aws

RUN chmod a+x /copy-channel-backup-on-change-testnet.sh
RUN chmod a+x /usr/local/bin/entrypoint.sh
RUN chmod a+x /unlock-or-init.js
RUN ln -s /${lndpackage} /lnd-main

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
