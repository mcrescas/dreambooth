#!/bin/zsh
if [ -d ".penv" ]; then
  source ./.penv/bin/activate
  echo "Using virtual env for Python"
else
  echo "You should use a virtual env. Generate one inside .penv folder"
  exit 1
fi

git clone https://github.com/facebookresearch/xformers.git
cd xformers
git submodule update --init --recursive

export CC=gcc
export CXX=g++
pip install -r requirements.txt
pip install -e .

exit 0
