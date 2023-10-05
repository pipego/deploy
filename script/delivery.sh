#!/bin/bash

# Delivery for runner
URL=$(curl -L -s https://api.github.com/repos/pipego/runner/releases/latest | grep -o -E "https://(.*)runner/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
curl -L -s "$URL" | tar xvz -C .
ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi

pushd pipego-runner-*
./script/docker.sh latest
docker push ghcr.io/pipego/runner:latest
popd

rm -rf pipego-runner-*

# Delivery for scheduler
URL=$(curl -L -s https://api.github.com/repos/pipego/scheduler/releases/latest | grep -o -E "https://(.*)scheduler/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
curl -L -s "$URL" | tar xvz -C .
ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi

pushd pipego-scheduler-*
./script/docker.sh latest
docker push ghcr.io/pipego/scheduler:latest
popd

rm -rf pipego-scheduler-*

# Delivery for cli
URL=$(curl -L -s https://api.github.com/repos/pipego/cli/releases/latest | grep -o -E "https://(.*)cli/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
curl -L -s "$URL" | tar xvz -C .
ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi

pushd pipego-cli-*
./script/docker.sh latest
docker push ghcr.io/pipego/cli:latest
popd

rm -rf pipego-cli-*

exit $ret
