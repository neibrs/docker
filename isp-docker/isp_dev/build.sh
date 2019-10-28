#!/bin/sh

docker pull neibrs/isp_dev

docker rm -f isp_dev
docker run -d --name isp_dev neibrs/isp_dev
if [ -d ./web.old ]; then
  sudo rm -rf ./web.old
fi
if [ -d ./web ]; then
  mv ./web ./web.old
fi
sudo docker cp isp_dev:/var/www/html ./web
docker stop isp_dev
docker rm isp_dev

sudo chown -R $USER ./web
sudo chmod -R g+w ./web

