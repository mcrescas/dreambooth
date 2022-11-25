#!/bin/zsh
if [ -d ".penv" ]; then
  source ./.penv/bin/activate
  echo "Using virtual env for Python"
else
  echo "You should use a virtual env. Generate one inside .penv folder"
  exit 1
fi

git clone https://github.com/TheLastBen/diffusers
pip install -q cmake
pip install -q torch
pip install -q torchvision
pip install -q ftfy
pip install -q git+https://github.com/TheLastBen/diffusers
pip install -q accelerate==0.12.0
pip install -q OmegaConf
pip install -q termcolor

wget https://github.com/TheLastBen/fast-stable-diffusion/raw/main/Dreambooth/Deps
path_dist=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())")
mv Deps Deps.7z
7z x Deps.7z
# cp -r usr/local/lib/python3.7/dist-packages /usr/local/lib/python3.7/
cp -r usr/local/lib/python3.7/dist-packages/* $path_dist
rm Deps.7z
rm -r usr
