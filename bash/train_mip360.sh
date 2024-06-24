#! /bin/bash

DEVICE_ID=$1

bash bash/train.sh mipnerf360 bicycle $DEVICE_ID
bash bash/train.sh mipnerf360 counter $DEVICE_ID
bash bash/train.sh mipnerf360 garden $DEVICE_ID
bash bash/train.sh mipnerf360 room $DEVICE_ID
bash bash/train.sh mipnerf360 bonsai $DEVICE_ID
bash bash/train.sh mipnerf360 kitchen $DEVICE_ID
bash bash/train.sh mipnerf360 stump $DEVICE_ID