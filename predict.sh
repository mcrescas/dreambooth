#!/bin/zsh

echo "Input the name of the Instance"
read INSTANCE_NAME

path_to_trained_model="trained/${INSTANCE_NAME}.ckpt"

share=''

# !nohup lt --port 7860 > srv.txt 2>&1 &
# time.sleep(2)
# !grep -o 'https[^ ]*' /content/srv.txt >srvr.txt
# time.sleep(2)
# srv= getoutput('cat /content/srvr.txt')

# !sed -i '1037s@.*@            self.server_name = "{srv[8:]}"@' /usr/local/lib/python3.7/dist-packages/gradio/blocks.py
# !sed -i '1039s@.*@            self.server_port = 443@' /usr/local/lib/python3.7/dist-packages/gradio/blocks.py
# !sed -i '1043s@.*@            self.protocol = "https"@' /usr/local/lib/python3.7/dist-packages/gradio/blocks.py  
        
# !sed -i '13s@.*@    "PUBLIC_SHARE_TRUE": "[32mConnected",@' /usr/local/lib/python3.7/dist-packages/gradio/strings.py

# !rm /content/srv.txt
# !rm /content/srvr.txt
# clear_output()


python stable-diffusion-webui/webui.py $share --disable-safe-unpickle --ckpt "$path_to_trained_model"
