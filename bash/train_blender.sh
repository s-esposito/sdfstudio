#! /bin/bash

DEVICE_ID=$1

bash bash/train.sh blender ship $DEVICE_ID
bash bash/train.sh blender drums $DEVICE_ID
bash bash/train.sh blender chair $DEVICE_ID
bash bash/train.sh blender ficus $DEVICE_ID
bash bash/train.sh blender hotdog $DEVICE_ID
bash bash/train.sh blender lego $DEVICE_ID
bash bash/train.sh blender materials $DEVICE_ID
bash bash/train.sh blender mic $DEVICE_ID