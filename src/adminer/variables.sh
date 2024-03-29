#!/usr/bin/env bash

MYSQLD_PORT="$(echo "${MYSQLD_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MYSQLD_HOST="$(echo "${MYSQLD_PORT}" | cut -d ":" -f1)"
export FACTER_MYSQLD_PORT="$(echo "${MYSQLD_PORT}" | cut -d ":" -f2)"

if [ -z "${MYSQLD_USERNAME}" ]; then
  MYSQLD_USERNAME="root"
fi

export FACTER_MYSQLD_USERNAME="${MYSQLD_USERNAME}"

if [ -z "${MYSQLD_PASSWORD}" ]; then
  MYSQLD_PASSWORD="root"
fi

export FACTER_MYSQLD_PASSWORD="${MYSQLD_PASSWORD}"

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

if [ -z "${TIMEOUT}" ]; then
  TIMEOUT="300"
fi

export FACTER_TIMEOUT="${TIMEOUT}"

if [ -z "${PROTOCOLS}" ]; then
  PROTOCOLS="https,http"
fi

PROTOCOLS=$(echo "${PROTOCOLS}" | tr "," "\n")

for PROTOCOL in ${PROTOCOLS}; do
  if [ "${PROTOCOL}" == "http" ]; then
    export FACTER_HTTP="1"
  fi

  if [ "${PROTOCOL}" == "https" ]; then
    export FACTER_HTTPS="1"
  fi
done
