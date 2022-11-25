#!/bin/zsh

# https://huggingface.co/runwayml/stable-diffusion-v1-5
Huggingface_Token="YOUR_TOKEN_HG"

token=$Huggingface_Token

# if [ -d "stable-diffusion-v1-5" ]; then
#     rm -r stable-diffusion-v1-5
# fi
mkdir stable-diffusion-v1-5
cd stable-diffusion-v1-5
git init
# git lfs install --system --skip-repo
git remote add -f origin  "https://USER:${token}@huggingface.co/runwayml/stable-diffusion-v1-5"
git config core.sparsecheckout true
echo -e "scheduler\ntext_encoder\ntokenizer\nunet\nmodel_index.json" > .git/info/sparse-checkout
git pull origin main

git clone "https://USER:${token}@huggingface.co/stabilityai/sd-vae-ft-mse"
mv sd-vae-ft-mse vae
rm -r .git
# cd /content/stable-diffusion-v1-5
rm model_index.json
sleep 1
wget "https://raw.githubusercontent.com/TheLastBen/fast-stable-diffusion/main/Dreambooth/model_index.json"
sed -i 's@"clip_sample": false@@g' scheduler/scheduler_config.json
sed -i 's@"trained_betas": null,@"trained_betas": null@g' scheduler/scheduler_config.json
sed -i 's@"sample_size": 256,@"sample_size": 512,@g' vae/config.json
