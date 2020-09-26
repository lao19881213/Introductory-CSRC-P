#!/bin/bash
#SBATCH --job-name=myjob  #makes it easier to find in squeue
#SBATCH --partition=purley-cpu # partition name
#SBATCH --nodes=2 # number of nodes
#SBATCH --tasks-per-node=1 #processes per node
#SBATCH --cpus-per-task=1 #cores per process
#SBATCH --time=00:05:00 # walltime requested
#SBATCH --export=NONE # start with a clean start with a clean start with a clean start with a clean start with a clean start with a clean start with a clean start with a clean start with a clean environment. i

#The next line is executed on the compute node
hostname

