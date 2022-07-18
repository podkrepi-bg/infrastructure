FROM google/cloud-sdk:392.0.0-alpine

RUN apk upgrade && apk add postgresql-client

ADD entrypoint.sh /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]