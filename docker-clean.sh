#!/bin/bash

docker image prune -f
docker container prune -f
docker network prune -f
docker volume prune -f

docker image prune -a -f
docker container prune -f
docker network prune -f
docker volume prune -f

docker image prune -f
docker container prune -f
docker network prune -f
docker volume prune -f

