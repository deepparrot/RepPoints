#!/usr/bin/env bash
source /workspace/venv/bin/activate
PYTHON=${PYTHON:-"python"}

pip install torch

apt-get git
git clone https://github.com/NVIDIA/apex
cd apex
pip install -v --no-cache-dir ./
cd ..

# copy files
cp -r src/reppoints_head/* mmdetection/mmdet/models/anchor_heads/
cp -r src/reppoints_detector/* mmdetection/mmdet/models/detectors/
cp -r src/reppoints_generator/* mmdetection/mmdet/core/anchor/
cp -r src/reppoints_assigner/* mmdetection/mmdet/core/bbox/assigners/

# install mmdetection
cd mmdetection
pip install -v -e .
cd ..
