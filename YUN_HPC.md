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
## 维护
```
周期性检查节点
周期性存储检查
```
```
web界面有警告
有问题-->保修
Lico-->监控 列表视图
点击IP地址查看问题
```
```
管理地址、保修 提供 序列号 IB地址
```
```
400-106-8888
抓日志
服务日志（压缩包）
```
```
SLURM管理
slurmctld mn01
scontrol show node <nodename>
scontril update node <nodename> state=resume
```
```
查看状态：mmgetstate -a
关闭GPFS：mmshutdown -a
mmshutdown -N hostname 
 开启GPFS
mmstartup -a
mmstartup 
收集支持数据
gpfs snap -N <>
检查DPFS磁盘状态
mmlsdisk 
```
```
设置限额：
mmsetquota
mmsetquota fs01 --user username --block 250G:300G
报告限额：
mmrepquota fs01 --block-size auto
列出单个用户限额
mmlsquota -u <username>
https://113.55.126.21:47443
```

```
关机：
psh all poweroff
先GPFS->关闭节点->在关mn01 （手动）
GPFS: mmshutdown -a
mn01: poweroff
```
```
/etc/slurm/slurm.conf
systemctl restart slurmctld
psh compute "systemctl restart slurmd"
psh c[001-003] "systemctl restart slurmd"
```

```
 端口管理：
vi /opt/openssh/9.5p1/etc/sshd_config
修改端口：
Port 9022
重启服务
systemctl 
```
 
```
查看被ban的ip
fail2ban-cilent status sshd
查看fail2ban日志
cat /var/log/fail2ban.log
```



