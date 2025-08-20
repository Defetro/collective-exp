#!/bin/bash
#SBATCH --job-name=collective-exp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=48:00:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

set -euo pipefail

if command -v module &> /dev/null; then
  module load cuda/11.8 || true
  module load anaconda || true
fi

ENV_NAME=collective-exp
if ! conda info --envs | grep -q "^${ENV_NAME} "; then
  conda create -y -n "${ENV_NAME}" python=3.10
fi
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "${ENV_NAME}"

pip install --upgrade pip
pip install -r requirements.txt

export DATASET_PATH="${DATASET_PATH:-$PWD/data/ml-1m/ratings.dat}"
export CUDA_VISIBLE_DEVICES="${CUDA_VISIBLE_DEVICES:-0}"

jupyter nbconvert --to python experiments/correct_final_one.ipynb --output experiments/correct_final_one.py
python experiments/correct_final_one.py
