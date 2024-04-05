#!/bin/bash

docker rm -f frontend
docker image rm sscwebapphw/frontend
docker pull sscwebapphw/frontend
docker-compose up --force-recreate -d