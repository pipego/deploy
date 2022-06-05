#!/bin/bash

os=$(go env GOOS)

if [ "$1" = "docker" ]; then
  if [ "$2" = "pull" ]; then
    docker pull ghcr.io/pipego/cli:latest
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
  elif [ "$2" = "run" ]; then
    docker run --rm ghcr.io/pipego/cli:latest
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
  fi
elif [ "$1" = "host" ]; then
  if [ "$2" = "pull" ]; then
    URL=$(curl -L -s https://api.github.com/repos/pipego/cli/releases/latest | grep -o -E "https://(.*)cli_(.*)_${os}_amd64.tar.gz")
    curl -L -s "$URL" | tar xvz -C .
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
    rm -f LICENSE README.md
    URL=$(curl -L -s https://api.github.com/repos/pipego/cli/releases/latest | grep -o -E "https://(.*)cli/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
    curl -L -s "$URL" | tar xvz -C .
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
    mv pipego-cli-*/config/config.yml .
    mv pipego-cli-*/test/data/runner.json .
    mv pipego-cli-*/test/data/scheduler.json .
    rm -rf pipego-cli-*
  elif [ "$2" = "run" ]; then
    chmod +x cli; ./cli --config-file=config.yml --runner-file=runner.json --scheduler-file=scheduler.json
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
  fi
else
  echo "Invalid argument: $1 $2"
  ret=1
fi

exit $ret
