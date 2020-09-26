#!/bin/bash 
#SBATCH --job-name=hello-mpi
#SBATCH --partition=purley-cpu
#SBATCH --nodes=1
#SBATCH --tasks-per-node=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=00:05:00
#SBATCH --export=NONE

# prepare MPI environment
module use /home/app/modulefiles
module load mpich/cpu-3.2.1-gcc-7.3.0

# launch MPI program
srun --export=all --mpi=pmi2 -N 1 -n 24 ./hello-mpi
