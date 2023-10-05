#!/bin/bash

if [ "$1" = "run" ]; then
  docker-compose -f deploy.yml up -d
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "stop" ]; then
  docker-compose -f deploy.yml stop
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "clean" ]; then
  docker-compose -f deploy.yml rm -f
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
else
  echo "Invalid argument: $1"
  ret=1
fi

exit $ret
