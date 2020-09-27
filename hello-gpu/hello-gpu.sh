#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1 #number of gpu devices
#SBATCH --mem=8g
#SBATCH --partition=inspur-gpu-opa
#SBATCH --export=NONE

# prepare GPU environment
module use /home/app/modulefiles
module load cuda/9.0

# launch GPU program
srun --export=all -N 1 -n 1 ./hello-gpu

