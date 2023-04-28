cd /home/webui
touch hello_world

cd ~/stable-diffusion-webui/models/Stable-diffusion
gdown 15zgfkYbrPjLA2j69VSiE_ITVRRFDF9I7 # owlstudio model

cd ~/stable-diffusion-webui/extensions
git clone https://github.com/Mikubill/sd-webui-controlnet.git
git clone https://github.com/yfszzx/stable-diffusion-webui-images-browser.git
git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git

cd ~/stable-diffusion-webui/extensions/sd-webui-controlnet/models
wget https://huggingface.co/kohya-ss/ControlNet-diff-modules/resolve/main/diff_control_sd15_openpose_fp16.safetensors
