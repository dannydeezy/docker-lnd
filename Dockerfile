FROM alpine

RUN apk --no-cache add wget tar bash \
  && wget https://github.com/lightningnetwork/lnd/releases/download/v0.6-beta/lnd-linux-amd64-v0.6-beta.tar.gz \
  && tar xzvf lnd-linux-amd64-v0.6-beta.tar.gz

EXPOSE 8080 9735 10009

ADD ./entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod a+x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]



