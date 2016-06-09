#!/usr/bin/env bash
# Only doing this because the CLI is part of HIL...
sudo apt-get update
sudo apt-get install -y git python-pip python-dev python-lxml
git clone https://github.com/CCI-MOC/haas.git
cd haas && sudo python setup.py install && cd ../

# Container
docker build --rm -t knikolla/hil .
docker run -d -p 127.0.0.1:5000:80 --name hil0 -e "DB=$1" knikolla/hil:latest

