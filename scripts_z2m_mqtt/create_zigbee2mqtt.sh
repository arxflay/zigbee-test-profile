#!/bin/sh
mkdir zigbee2mqtt
mkdir zigbee2mqtt/data
cat << EOF > zigbee2mqtt/data/configuration.yaml
homeassistant: false

permit_join: true

mqtt:
    base_topic: zigbee2mqtt
    server: 'mqtt://172.17.0.1:1883'
    user: gardenbro
    password: paladin

serial:
    port: /dev/ttyUSB0

frontend:
    port: 20000
EOF

cat << EOF > zigbee2mqtt/docker-compose.yaml
version: '3.8'
services:
    zigbee2mqtt:
        container_name: zigbee2mqtt
        image: koenkk/zigbee2mqtt
        restart: unless-stopped
        volumes:
            - ./data:/app/data
            - /run/udev:/run/udev:ro
        ports:
            # Frontend port
            - 8080:8080
        environment:
            - TZ=Europe/Prague
        devices:
            # Make sure this matched your adapter location
            - /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0:/dev/ttyUSB0
EOF
