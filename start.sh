#!/bin/bash
echo "Container Started"
export PYTHONUNBUFFERED=1

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
    echo "SSH Service Started"
fi

sleep infinity