#!/bin/bash
##########################################################################
# script to check if the ngnix-proxy network exists
# should be called before "docker-compose up -d"
##########################################################################

if [ ! "$(docker network ls | grep reverse-proxy)" ]; then
  echo "Creating reverse-proxy network ..."
  docker network create --driver bridge reverse-proxy
else
  echo "reverse-proxy network exists."
fi