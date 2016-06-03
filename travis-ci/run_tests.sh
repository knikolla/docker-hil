#!/usr/bin/env bash
IP=$(ifconfig docker0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
sed -e "s|%IP%|$IP|g" -i haas.cfg

haas list_projects