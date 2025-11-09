#!/bin/sh
# Evaluation script for Animals

MODEL="ai85cdnet"
DATASET="paper_vs_glass"
QUANTIZED_MODEL="../ai8x-training/logs/2025.11.07-171723/qat_best-quantized.pth.tar"

# Run evaluation
python train.py \
  --model $MODEL \
  --dataset $DATASET \
  --confusion \
  --evaluate \
  --exp-load-weights-from $QUANTIZED_MODEL \
  -8 \
  --save-sample 1 \
  --device MAX78000 "$@"