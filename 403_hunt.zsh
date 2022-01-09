#!/bin/zsh

target=$1

root_dir="/root/HuntTheBug/"

python3 /root/tools/byp4xx/byp4xx.py $target

python3  /root/tools/403bypasser/403bypasser.py -u $target -d /

cd /root/tools/bypass-403/

./bypass-403.sh $target