#!/bin/bash

if [ "$1" = "docker" ]; then
  if [ "$2" = "pull" ]; then
    docker pull ghcr.io/pipego/demo:latest
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
  elif [ "$2" = "run" ]; then
    docker run --rm ghcr.io/pipego/demo:latest
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
  fi
elif [ "$1" = "host" ]; then
  if [ "$2" = "pull" ]; then
    URL=$(curl -L -s https://api.github.com/repos/pipego/demo/releases/latest | grep -o -E "https://(.*)demo_(.*)_linux_amd64.tar.gz")
    curl -L -s "$URL" | tar xvz -C .
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
    rm -f LICENSE README.md
    URL=$(curl -L -s https://api.github.com/repos/pipego/demo/releases/latest | grep -o -E "https://(.*)demo/tarball/v([0-9]{1,}\.)+[0-9]{1,}")
    curl -L -s "$URL" | tar xvz -C .
    ret=$?
    if [ $ret -ne 0 ]; then
      exit $ret
    fi
    mv pipego-demo-*/config/config.yml demo.yml
    rm -rf pipego-demo-*
  elif [ "$2" = "run" ]; then
    chmod +x demo; ./demo --config-file=demo.yml
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
