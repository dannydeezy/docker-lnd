FROM alpine

ENV lndpackage lnd-linux-amd64-v0.6-beta
ENV sha256sum ef37b3658fd864dfb3af6af29404d92337229378c24bfb78aa2010ede4cd06af
ENV password bitgobitgo

RUN apk --no-cache add wget tar bash nodejs nodejs-npm \
  && wget https://github.com/lightningnetwork/lnd/releases/download/v0.6-beta/${lndpackage}.tar.gz \
  && sha256sum ${lndpackage}.tar.gz \
  && echo "${sha256sum}  ${lndpackage}.tar.gz" > expected-sha256sum.txt \
  && sha256sum -c expected-sha256sum.txt

RUN tar xzvf ${lndpackage}.tar.gz

EXPOSE 8080 9735 10009

ADD ./entrypoint.sh /usr/local/bin/entrypoint.sh
ADD ./lncli-unlock.js /lncli-unlock.js

RUN chmod a+x /usr/local/bin/entrypoint.sh
RUN chmod a+x /lncli-unlock.js

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
