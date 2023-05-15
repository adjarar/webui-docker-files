#!/bin/bash

sudo -u webui bash << 'EOF'

cd ~
git clone https://github.com/adjarar/webui-files-and-settings.git
cd webui-files-and-settings
chmod +x settings_and_downloads.sh

bash settings_and_downloads.sh

EOF
