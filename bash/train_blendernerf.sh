#! /bin/bash

DEVICE_ID=$1

bash bash/train.sh blendernerf plushy $DEVICE_ID
bash bash/train.sh blendernerf hairy_monkey $DEVICE_ID