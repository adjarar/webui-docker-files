cd ~/stable-diffusion-webui
wget https://raw.githubusercontent.com/adjarar/webui-docker-files/main/webui-user.sh -O webui-user.sh
wget https://raw.githubusercontent.com/adjarar/webui-docker-files/main/config.json -O config.json

cd ~/stable-diffusion-webui/models/Stable-diffusion
gdown 15zgfkYbrPjLA2j69VSiE_ITVRRFDF9I7 # owlstudio model

cd ~/stable-diffusion-webui/extensions
git clone https://github.com/Mikubill/sd-webui-controlnet.git
git clone https://github.com/yfszzx/stable-diffusion-webui-images-browser.git
git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git
git clone https://github.com/pkuliyi2015/multidiffusion-upscaler-for-automatic1111.git
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui-rembg.git

cd ~/stable-diffusion-webui/extensions/sd-webui-controlnet/models
wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth
wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth
wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.pth
wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1p_sd15_depth.pth
