# Collective Experiment (Final)

Final code + SLURM script to reproduce results from `experiments/correct_final_one.ipynb`.

## Quickstart
```bash
conda create -n collective-exp python=3.10 -y
conda activate collective-exp
pip install -r requirements.txt
jupyter notebook experiments/correct_final_one.ipynb
```

## SLURM
```bash
sbatch run.sh
```

Env vars:
- `DATASET_PATH`: path to `ratings.dat` (default: `./data/ml-1m/ratings.dat`)
- `CUDA_VISIBLE_DEVICES`: GPU selection
