#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y git python-pip python-dev python-lxml

git clone https://github.com/CCI-MOC/haas.git
cd haas && sudo python setup.py install && cd ../

docker network create --subnet=192.168.98.0/24 hil-net

# PostgreSQL container
docker run -d --name postgres0 --net=hil-net --ip=192.168.98.2 \
    -e POSTGRESQL_USER=hil -e POSTGRESQL_PASS=hilpass -e POSTGRESQL_DB=hil \
    orchardup/postgresql

# Container
docker build --rm -t knikolla/hil .
docker run -d -p 5000:80 --name hil0 --net=hil-net knikolla/hil:latest

