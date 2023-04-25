#!/bin/bash

wget https://raw.githubusercontent.com/adjarar/webui-docker-files/main/on_docker_start.sh
chmod +x on_docker_start.sh

# Switch to the webui user
su -s /bin/bash webui << 'EOF'

on_docker_start.sh

EOF
