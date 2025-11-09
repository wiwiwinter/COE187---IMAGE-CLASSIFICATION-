#!/bin/sh
# Evaluation script for Animals

MODEL="ai85cdnet"
DATASET="burger_vs_pizza"
QUANTIZED_MODEL="../ai8x-training/logs/2025.11.10-010300/best-quantized.pth.tar"

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