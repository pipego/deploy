#!/bin/bash

if [ "$1" = "fetch" ]; then
  URL=$(curl -L -s https://api.github.com/repos/pipego/runner/releases/latest | grep -o -E "https://(.*)runner/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
  curl -L -s "$URL" | tar xvz -C .
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
  URL=$(curl -L -s https://api.github.com/repos/pipego/scheduler/releases/latest | grep -o -E "https://(.*)scheduler/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
  curl -L -s "$URL" | tar xvz -C .
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
  URL=$(curl -L -s https://api.github.com/repos/pipego/cli/releases/latest | grep -o -E "https://(.*)cli/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
  curl -L -s "$URL" | tar xvz -C .
  ret=$?
  if [ $ret -ne 0 ]; then
    exit $ret
  fi
elif [ "$1" = "build" ]; then
  pushd pipego-runner-*
  version=latest make docker
  popd
  pushd pipego-scheduler-*
  version=latest make docker
  popd
  pushd pipego-cli-*
  version=latest make docker
  popd
elif [ "$1" = "clean" ]; then
  rm -rf pipego-cli-*
  rm -rf pipego-scheduler-*
  rm -rf pipego-runner-*
else
  echo "Invalid argument: $1"
  ret=1
fi

exit $ret
