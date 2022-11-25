#!/bin/zsh

dataset="person_ddim" #@param ["man_euler", "man_unsplash", "person_ddim", "woman_ddim", "blonde_woman"]
git clone https://github.com/djbielejeski/Stable-Diffusion-Regularization-Images-${dataset}.git

mkdir -p regularization_images/${dataset}
mv -v Stable-Diffusion-Regularization-Images-${dataset}/${dataset}/*.* regularization_images/${dataset}
CLASS_DIR="/content/regularization_images/${dataset}"

echo "Input 'name' of the concept:"
read token
echo "Preparing data folder for '${token}' ('data/${token}). Please copy all the cropped photos inside"
mkdir -p models/${token}
mkdir -p data/${token}
