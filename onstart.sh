#!/bin/bash

wget https://raw.githubusercontent.com/adjarar/webui-docker-files/main/on_docker_start.sh
chmod +x on_docker_start.sh
mv on_docker_start.sh /home/webui/

# Switch to the webui user
su -s /bin/bash webui << 'EOF'

cd ~
bash on_docker_start.sh

EOF
