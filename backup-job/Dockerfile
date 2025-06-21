FROM google/cloud-sdk:527.0.0-alpine

RUN apk upgrade && apk add postgresql17-client --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main

ADD entrypoint.sh /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]