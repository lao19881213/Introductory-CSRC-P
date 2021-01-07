#!/bin/bash

#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=test
#SBATCH --time=02:00:00
#SBATCH --error=err-%j.log
#SBATCH --partition=arm

module use /home/app/modulefiles
module load python/arm-3.6.5
module load mpich/arm-3.2.1-gcc-7.3.0


srun --mpi=pmi2 -N 4 -n 4 python test_mpi4py.py
