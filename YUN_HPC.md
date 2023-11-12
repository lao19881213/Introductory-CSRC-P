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
```



