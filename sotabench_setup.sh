#!/usr/bin/env bash
source /workspace/venv/bin/activate
PYTHON=${PYTHON:-"python"}

pip install torch

apt-get git
git clone https://github.com/NVIDIA/apex
cd apex
pip install -v --no-cache-dir ./
cd ..

git clone https://github.com/open-mmlab/mmdetection/
cd mmdetection
git checkout 6e48d28198ea5d6dcf6a9618fd8d2832b5eaf538
cd ..
# copy files
cp -r src/reppoints_head/* mmdetection/mmdet/models/anchor_heads/
cp -r src/reppoints_detector/* mmdetection/mmdet/models/detectors/
cp -r src/reppoints_generator/* mmdetection/mmdet/core/anchor/
cp -r src/reppoints_assigner/* mmdetection/mmdet/core/bbox/assigners/

# install mmdetection
cd mmdetection

echo "Installing..."
$PYTHON setup.py develop
cd ..
