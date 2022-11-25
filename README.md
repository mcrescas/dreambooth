
# Installation
Use a local Python environment:

```
python3 -m venv .penv
```

Install CUDA Dev dependencies for xformers (you need to complete with your cuda version):
```
sudo apt install libcusparse-dev-xx
sudo apt install libcusolver-dev-xx
sudo apt install libcublas-dev-xx
sudo apt install libcurand-dev-xx

sudo apt install git-lfs
```

First, install xformers inside the virtualenv:
```
./install_xformers.sh
```

Second, install the rest of dependencies:
```
./install.sh
```

Third, download stable diffusion model (you need to fill your token obtained in the web inside the script).
Make sure you've accepted the terms in [https://huggingface.co/runwayml/stable-diffusion-v1-5](https://huggingface.co/runwayml/stable-diffusion-v1-5):
```
./get-SD.sh
```

# Train the system
First, generate the folder with the images of the subject (the 'name' should be a anything but a strange word that stable diffusion does not know yet).
```
./prepare.sh
```

Second, fill this folder with all the images (resolution of 512x512)

Third, launch the script (modify the number of iterations as desired inside the script)
```
./train.sh
```

# Generate images
First, install ui dependencies:
```
./install_ui.sh
```

Execute web ui (the link should be printed in the terminal output):
```
./predict.sh
```