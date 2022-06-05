# deploy

[![License](https://img.shields.io/github/license/pipego/scheduler.svg)](https://github.com/pipego/scheduler/blob/main/LICENSE)



## Introduction

*deploy* is the deployment of [pipego](https://github.com/pipego).



## Diagram

![diagram](diagram.png)



## Flow

![flow](flow.png)



## Deploy

```bash
cd script

# Start
./deploy.sh start

# Stop
./deploy.sh stop

# Clean
./deploy.sh clean
```



## CLI

```bash
cd script

# Docker mode
./cli.sh docker pull
./cli.sh docker run

# Host mode
./cli.sh host pull
./cli.sh host run
```



## License

Project License can be found [here](LICENSE).
