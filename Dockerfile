FROM alpine:3.19.1

WORKDIR /usr/src
RUN apk update && apk upgrade && apk add curl bind-tools

COPY ddns-update.sh /usr/src
RUN chmod 755 /usr/src/ddns-update.sh

CMD /usr/src/ddns-update.sh
