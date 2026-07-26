#!/bin/sh

if [ "$#" -lt 2 ]; then
  printf 'usage: %s INTERVAL COMMAND [ARG ...]\n' "$0" >&2
  exit 2
fi

interval=$1
shift

while true; do
  "$@"
  sleep "$interval"
done
