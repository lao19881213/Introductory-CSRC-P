# YUN HPC  
## Login
```
IP: 113.55.126.21
1. SSH
port 22
or 9022
2. Web 
https://113.55.126.21:9443
```
## Nodes
```
1 head: compile install
4 storage
5 compute nodes
```
## software
```
centos
gcc 8.4.1
/share/intel/2022.2.3
modulefiles: /share/base/modulefiles
SLURM 
GPFS 5.1
```
## File system /share 1.8 PB
```
/share/apps: software
/share/base: modulefiles, base software gcc 
/share/0_download
/share/intel
/share/home/<username>: user home
/share/data
```
## data transport
```
1.
scp
rsync
Xftp
port: 22/9022
2. web
```
## Installation
```
RPM
no RPM --> /share/apps, /share/home/<username>
```
## SLURM
``` 
srun -N 1 --nodelist=c002 hostname (-w specific node)
surn -N 1 --exclude=c002 hostname (-x exclude node) 
srun -n 4 hostname (single node)
srun -N 2 hostname (two nodes)
srun -N 2 -n 2 hostname (two nodes one node one process)
```
```
shownodes
```
```
#!/bin/bash  
#SBATCH --job-name=myjob  #makes it easier to find in squeue  
#SBATCH --partition=cpu # partition name  
#SBATCH --nodes=2 # number of nodes  
#SBATCH --tasks-per-node=1 #processes per node  
#SBATCH --cpus-per-task=1 #cores per process
#SBATCH --mem 2048 
#SBATCH --time=00:05:00 # walltime requested  

srun /usr/bin/hostname 
```
```
scontrol show job <jobid> | grep Memory
```



