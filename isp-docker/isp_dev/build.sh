#!/bin/sh

docker pull 114.215.42.138:5000/eabax_dev

docker rm -f eabax_dev
docker run -d --name eabax_dev 114.215.42.138:5000/eabax_dev
if [ -d ./web.old ]; then
  sudo rm -rf ./web.old
fi
if [ -d ./web ]; then
  mv ./web ./web.old
fi
sudo docker cp eabax_dev:/var/www/html ./web
docker stop eabax_dev
docker rm eabax_dev

sudo chown -R $USER ./web
sudo chmod -R g+w ./web

