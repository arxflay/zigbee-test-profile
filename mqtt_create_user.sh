#!/bin/sh

if [ "$#" -ne 2 ]; then
    echo "Usage: container_id user"
else
    sudo docker exec -it $1 sh -c "mosquitto_passwd -c /mosquitto/config/pwfile $2"
fi
