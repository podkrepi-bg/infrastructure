FROM google/cloud-sdk:422.0.0-alpine

RUN apk upgrade && apk add postgresql-client

ADD entrypoint.sh /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]