#!/bin/bash -l
#SBATCH --job-name=hello-serial
#SBATCH –partition=purley-cpu
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --export=NONE
# load modules
module use /home/app/modulefiles
module load python/cpu-3.7.4
# launch serial python script
python3 hello-serial.py

