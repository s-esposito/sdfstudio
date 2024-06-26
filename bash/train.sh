#! /bin/bash

# usage:
# bash test.sh <DATASET_NAME> <SCENE_NAME> <CUDA_DEVICE_ID>

#############################

DATASET_NAME=$1
SCENE_NAME=$2
DEVICE_ID=$3

# METHOD_NAME="bakedsdf"
METHOD_NAME="instant-ngp"
RUNS_PATH=$(grep 'runs:' config/paths_config.cfg | sed 's/[^/]*//; s/[\{\} ,"]//g')
DATA_PATH=$(grep 'datasets:' config/paths_config.cfg | sed 's/[^/]*//; s/[\{\} ,"]//g')

echo "RUNS_PATH: $RUNS_PATH"
echo "DATA_PATH: $DATA_PATH"

# RUN_ID format: YYYY-MM-DD-HHMMSS
RUN_ID=$(date +'%Y-%m-%d-%H%M%S')
# RUN_ID="2024-06-12-114155"  # $(date +'%Y-%m-%d-%H%M%S')
EXP_NAME="base"
OUTPUT_PATH=$RUNS_PATH/$METHOD_NAME/$EXP_NAME/$SCENE_NAME/$RUN_ID
echo "OUTPUT_PATH: $OUTPUT_PATH"

export WANDB__SERVICE_WAIT=300
export CUDA_VISIBLE_DEVICES=$DEVICE_ID
export OMP_NUM_THREADS=16

# ----------------------------------------------------------

# ## bakedsdf
# ns-train $METHOD_NAME \
# --experiment-name $EXP_NAME \
# --vis wandb \
# --output-dir $OUTPUT_PATH \
# --timestamp $RUN_ID \
# --pipeline.model.far-plane 6 \
# --pipeline.model.far-plane-bg 6 \
# --pipeline.model.background-color white \
# --trainer.max-num-iterations 20001 \
# blender-data \
# --data $DATA_PATH/$DATASET_NAME/$SCENE_NAME

# # bake mesh
# ns-extract-mesh --load-config $OUTPUT_PATH/config.yml \
# --output-path $OUTPUT_PATH/meshes/0.ply

# # # render mesh
# # ns-render-mesh --meshfile $OUTPUT_PATH/meshes/0.ply \
# # --traj interpolate  \
# # --output-path $OUTPUT_PATHrenders/0.mp4 \
# # blender-data \
# # --data $DATA_PATH/$DATASET_NAME/$SCENE_NAME

# ----------------------------------------------------------

# instant-ngp (blender-like data)
ns-train $METHOD_NAME \
--experiment-name $EXP_NAME \
--vis wandb \
--output-dir $OUTPUT_PATH \
--timestamp $RUN_ID \
--pipeline.model.far-plane 6 \
--pipeline.model.background-color white \
--pipeline.model.alpha-thre 0 \
--trainer.max-num-iterations 200001 \
blender-data \
--data $DATA_PATH/$DATASET_NAME/$SCENE_NAME

# ns-train $METHOD_NAME \
# --vis wandb \
# --output-dir $OUTPUT_PATH \
# --timestamp $RUN_ID \
# sdfstudio-data \
# --data $DATA_PATH/$DATASET_NAME/$SCENE_NAME

ns-eval --load-config $OUTPUT_PATH/config.yml \
--output-path $OUTPUT_PATH/output.json \
--output-images-path $OUTPUT_PATH/renders

# --pipeline.model.sdf-field.inside-outside False \
# --trainer.steps-per-eval-all-images 20000 \
# --trainer.max-num-iterations 20001 \