#! /bin/bash

# usage:
# bash test.sh <DATASET_NAME> <SCENE_NAME> <CUDA_DEVICE_ID>

#############################

DATASET_NAME=$1
SCENE_NAME=$2
DEVICE_ID=$3

METHOD_NAME="bakedangelo"
RUNS_PATH=$(grep 'runs:' config/paths_config.cfg | sed 's/[^/]*//; s/[\{\} ,"]//g')
DATA_PATH=$(grep 'datasets:' config/paths_config.cfg | sed 's/[^/]*//; s/[\{\} ,"]//g')

echo "RUNS_PATH: $RUNS_PATH"
echo "DATA_PATH: $DATA_PATH"

# RUN_ID format: YYYY-MM-DD-HHMMSS
RUN_ID=$(date +'%Y-%m-%d-%H%M%S')
# RUN_ID="2024-06-11-123117"  # $(date +'%Y-%m-%d-%H%M%S')
OUTPUT_PATH=$RUNS_PATH/surf/$METHOD_NAME/$SCENE_NAME/$RUN_ID
echo "OUTPUT_PATH: $OUTPUT_PATH"

export WANDB__SERVICE_WAIT=300
export CUDA_VISIBLE_DEVICES=$DEVICE_ID
export OMP_NUM_THREADS=16

ns-train $METHOD_NAME \
--vis wandb \
--output-dir $OUTPUT_PATH \
--timestamp $RUN_ID \
--pipeline.model.sdf-field.inside-outside False \
--trainer.steps-per-eval-all-images 20000 \
--trainer.max-num-iterations 20001 \
sdfstudio-data \
--data $DATA_PATH/$DATASET_NAME/$SCENE_NAME

# ns-train $METHOD_NAME \
# --vis wandb \
# --output-dir $OUTPUT_PATH \
# --timestamp $RUN_ID \
# --pipeline.model.background-color white \
# --pipeline.model.sdf-field.inside-outside False \
# --trainer.steps-per-eval-all-images 20000 \
# --trainer.max-num-iterations 20001 \
# blender-data \
# --data $DATA_PATH/$DATASET_NAME/$SCENE_NAME

# --experiment-name $EXP_NAME 
# --pipeline.model.sdf-field.inside-outside False \
# --trainer.steps-per-eval-all-images 20000 \
# --trainer.max-num-iterations 20001 \