#!/bin/sh

if [[ -z "${SERVER}" ]] || [[ -z "${ZONE}" ]] || [[ -z "${HOST}" ]] || [[ -z "${KEY}" ]]; then echo "Missing parameters, not executing"

else

  CURRIP=`/usr/bin/curl -s https://api.ipify.org`
  if ! expr "$CURRIP" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
    return
  fi

  CURRDNSIP=`/usr/bin/dig @${SERVER} ${HOST}.${ZONE} +short`
  if ! expr "$CURRDNSIP" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
    return
  fi

  if [[ "${CURRIP}" = "${CURRDNSIP}" ]]; then
    return
  fi

  echo "server ${SERVER}" > /tmp/ddns-update
  echo "zone ${ZONE}" >> /tmp/ddns-update
  echo "update del ${HOST}.${ZONE}." >> /tmp/ddns-update
  echo "update add ${HOST}.${ZONE}. 60 A ${CURRIP}" >> /tmp/ddns-update
  echo "send" >> /tmp/ddns-update

  /usr/bin/nsupdate -k ${KEY} -v /tmp/ddns-update

fi
