#!/bin/bash

sudo docker cp php:/var/www/html ./web
docker stop php
docker rm php

sudo chown -R $USER ./web
sudo chmod -R g+w ./web

