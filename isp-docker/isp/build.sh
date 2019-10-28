#!/bin/bash

docker-compose up -d

#docker rm -f isp
#docker run -d --name isp 114.215.42.138:5000/isp
if [ -d ./web.old ]; then
  sudo rm -rf ./web.old
fi
if [ -d ./web ]; then
  mv ./web ./web.old
fi
sudo docker cp isp:/var/www/html ./web
docker stop isp
docker rm isp

sudo chown -R $USER ./web
sudo chmod -R g+w ./web

