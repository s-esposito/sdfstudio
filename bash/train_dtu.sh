#! /bin/bash

DEVICE_ID=$1

bash bash/train.sh dtu dtu_scan83 $DEVICE_ID
bash bash/train.sh dtu dtu_scan105 $DEVICE_ID