#!/bin/bash

sudo -u webui bash << 'EOF'

cd ~
git clone https://github.com/adjarar/webui-invoke-init.git
cd webui-invoke-init
chmod +x init.sh

bash init.sh

EOF
