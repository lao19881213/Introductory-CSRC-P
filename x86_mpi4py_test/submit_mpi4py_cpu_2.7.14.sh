#!/bin/bash

#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=test
#SBATCH --time=02:00:00
#SBATCH --error=err-%j.log
#SBATCH --partition=purley-cpu

module use /home/software/modulefiles
module load python/cpu-2.7.14
module load mpich/cpu-3.2.1


srun --mpi=pmi2 -N 4 -n 4 python test_mpi4py.py
