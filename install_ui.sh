#!/bin/zsh

if [ -d ".penv" ]; then
  source ./.penv/bin/activate
  echo "Using virtual env for Python"
else
  echo "You should use a virtual env. Generate one inside .penv folder"
  exit 1
fi

git clone https://github.com/CompVis/stable-diffusion
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui

if [ ! -d "stable-diffusion/src/k-diffusion/k_diffusion" ]; then
    mkdir stable-diffusion/src
    cd stable-diffusion/src
    git clone https://github.com/CompVis/taming-transformers
    git clone https://github.com/openai/CLIP
    mv CLIP clip
    git clone https://github.com/TencentARC/GFPGAN
    mv  GFPGAN/gfpgan ../../stable-diffusion-webui
    git clone https://github.com/salesforce/BLIP
    mv  BLIP blip
    git clone https://github.com/sczhou/CodeFormer
    mv  CodeFormer codeformer
    git clone https://github.com/xinntao/Real-ESRGAN
    mv  Real-ESRGAN/ realesrgan
    git clone https://github.com/crowsonkb/k-diffusion.git
    cp -r k-diffusion/k_diffusion ../../stable-diffusion-webui
    git clone https://github.com/Hafiidz/latent-diffusion
    cp -r  latent-diffusion/ldm ../../stable-diffusion-webui
fi

path_dist=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")
wget https://github.com/TheLastBen/fast-stable-diffusion/raw/main/Dependencies/Dependencies_AUT.1
wget https://github.com/TheLastBen/fast-stable-diffusion/raw/main/Dependencies/Dependencies_AUT.2
mv Dependencies_AUT.1 Dependencies_AUT.7z.001
mv Dependencies_AUT.2 Dependencies_AUT.7z.002
7z x Dependencies_AUT.7z.001
sleep 2
rm -r usr/local/lib/python3.7/dist-packages/transformers
rm -r usr/local/lib/python3.7/dist-packages/transformers-4.19.2.dist-info
rm -r usr/local/lib/python3.7/dist-packages/diffusers
rm -r usr/local/lib/python3.7/dist-packages/diffusers-0.3.0.dist-info
rm -r usr/local/lib/python3.7/dist-packages/accelerate
rm -r usr/local/lib/python3.7/dist-packages/accelerate-0.12.0.dist-info
cp -r usr/local/lib/python3.7/dist-packages/* $path_dist
rm -r usr
rm Dependencies_AUT.7z.001
rm Dependencies_AUT.7z.002
cd stable-diffusion-webui/ldm/modules
wget -O attention.py https://raw.githubusercontent.com/TheLastBen/fast-stable-diffusion/main/precompiled/attention.py

pip install -q chardet
pip install -q opencv-python
pip install -q matplotlib
pip install -q pandas
pip install -q aiohttp
pip install -q fsspec
pip install -q jinja2
pip install -q click
pip install -q cffi
pip install -q protobuf==3.20
pip install -q absl-py
pip install -q gdown
pip install -q promise

# cd stable-diffusion-webui/modules
# wget -O paths.py https://raw.githubusercontent.com/TheLastBen/fast-stable-diffusion/main/AUTOMATIC1111_files/paths.py
