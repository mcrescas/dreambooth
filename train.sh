#!/bin/zsh

if [ -d ".penv" ]; then
  source ./.penv/bin/activate
  echo "Using virtual env for Python"
else
  echo "You should use a virtual env. Generate one inside .penv folder"
  exit 1
fi

precision="fp16" # [fp16, no]

Training_Steps="2500" #@param{type: 'string'}
#@markdown - Keep it around 1600 to avoid overtraining.

Seed=75576 #@param{type: 'number'}

Caption=''
stpsv="500"
stp="500"

MODEL_NAME="stable-diffusion-v1-5"

echo "Input the name of token to be used:"
read INSTANCE_NAME
echo "Number of iterations:"
read Training_Steps

SUBJECT_TYPE="person"
dataset="person_ddim"
SUBJECT_IMAGES="500"
OUTPUT_DIR="models/${INSTANCE_NAME}"

INSTANCE_DIR="data/${INSTANCE_NAME}"
CLASS_DIR="regularization_images/${dataset}"

PT="photo of ${INSTANCE_NAME} ${SUBJECT_TYPE}"
CPT="a photo of a ${SUBJECT_TYPE}, ultra detailed"

accelerate launch diffusers/examples/dreambooth/train_dreambooth.py \
    $Caption \
    --save_starting_step=$stpsv \
    --save_n_steps=$stp \
    --train_text_encoder \
    --pretrained_model_name_or_path="$MODEL_NAME" \
    --instance_data_dir="$INSTANCE_DIR" \
    --class_data_dir="$CLASS_DIR" \
    --output_dir="$OUTPUT_DIR" \
    --with_prior_preservation --prior_loss_weight=1.0 \
    --instance_prompt="$PT"\
    --class_prompt="$CPT" \
    --seed=$Seed \
    --resolution=512 \
    --mixed_precision=$precision \
    --train_batch_size=1 \
    --gradient_accumulation_steps=1 --gradient_checkpointing \
    --use_8bit_adam \
    --learning_rate=1e-6 \
    --lr_scheduler="constant" \
    --lr_warmup_steps=0 \
    --center_crop \
    --max_train_steps=$Training_Steps \
    --num_class_images=$SUBJECT_IMAGES

if [ -f "models/${INSTANCE_NAME}/unet/diffusion_pytorch_model.bin" ]; then
  echo "Almost done ..."
  wget -O convertosd.py https://github.com/TheLastBen/fast-stable-diffusion/raw/main/Dreambooth/convertosd.py

#   if precision=="no":
#     !sed -i '226s@.*@@' /content/convertosd.py
  sed -i "201s@.*@    model_path = '${OUTPUT_DIR}'@" convertosd.py
  sed -i "202s@.*@    checkpoint_path= 'trained/${INSTANCE_NAME}.ckpt'@" convertosd.py
  python convertosd.py

  if [ -f "trained/${INSTANCE_NAME}.ckpt" ]; then
    echo "DONE, the CKPT model is in your Gdrive"
  else
    echo "Something went wrong"
  fi
fi
