# Introductory-CSRC-P
An introductory supercomputing course developed by the SHAO SKA team.

# China SKA Regional Centre Prototype (CSRC-P) User Manual  

China SKA Regional Centre Prototype (CSRC-P) systems can use Slurm for resource and job management to avoid mutual interference and improve operational efficiency. All jobs that need to be run, whether for program debugging or business calculations, must be submitted through interactive parallel srun, batch submittion sbatch, or distributed salloc commands, and related commands can be used to query the job status after submission. Please do not directly run jobs (except compiling) on the login node, so as not to affect the normal use of other users.

* [Querying SLURM Partitions](#Querying-SLURM-Partitions)
* [Querying the Queue](#Querying-the-Queue)
* [Job Request](#Job-Request)
* [Jobscripts](#Jobscripts)
* [Serial python example](#Serial-python-example)
* [Lauching Paralle Programs](#Lauching-Paralle-Programs)
* [GPU Example](#GPU-Example)
* [Interactive Jobs](#Interactive-Jobs)
* [Job cancel](Job-cancel)

 
A SLURM partition is a queue, which is all the partition that are managed by a single SLURM daemon.
## Querying SLURM Partitions 
To list the partition when logged into a machine:  
`sinfo`  
To get all partitions in all local clusters:
`sinfo –M all`    
**For example**:
```
[blao@x86-logon01 ~]$ sinfo  
PARTITION      AVAIL  TIMELIMIT  NODES  STATE NODELIST  
arm               up   infinite      1  down* taishan-arm-cpu10  
arm               up   infinite      1  drain taishan-arm-cpu01  
arm               up   infinite      8   idle taishan-arm-cpu[02-09]  
purley-cpu*       up   infinite      1  alloc purley-x86-cpu01  
purley-cpu*       up   infinite      7   idle purley-x86-cpu[02-08]  
sugon-gpu         up   infinite      1   idle sugon-gpu01  
inspur-gpu-opa    up   infinite      1    mix inspur-gpu02  
inspur-gpu-ib     up   infinite      1  down* inspur-gpu01  
knm               up   infinite      4  down* knm-x86-cpu[01-04]  
knl               up   infinite      1  down* knl-x86-cpu02  
all-gpu           up   infinite      1  down* inspur-gpu01  
all-gpu           up   infinite      1    mix inspur-gpu02  
all-gpu           up   infinite      1   idle sugon-gpu01   
```
Where PARTITION represents the partition name. AVAIL represents the status of the partition, the up is available, and the down is not available. TIMELIMIT represents the maximum time the program runs, and infinite represents unlimited, the limit format is days-houres:minutes:seconds. NODES represents the number of nodes. NODELIST is Node list. STATE represents the running state of the node.    
```
STATE: node state, possible states include:    
          -allocated, alloc: allocated  
          -completing, comp: completing  
          -down: Down  
          -drained, drain: has lost vitality  
          -fail: failure  
          -idle: idle  
          -mix: mix, the node is running jobs, but some idle CPU cores can accept new jobs  
          -reserved, resv: resource reservation  
          -unknown, unk: unknown reason  
```
It is important to use the correct system and partition for each part of a workflow:
| Partition      | Purpose    |
| :------------- | :--------- |
| `arm`	|Many core workflows, many serial of shared memory (OpenMP) jobs, large distributed memory (MPI) jobs|
|`sugon-gpu`, `inspur-gpu-opa`, `inspur-gpu-ib`, `all-gpu`	| GPU-accelerated jobs, artificial Intelligence jobs|
|`purley-cpu`,`hw`,`all-x86-cpu`	| Many serial of shared memory (OpenMP) jobs, large distributed memory (MPI) jobs|

## Querying the Queue  
squeue is used to view job and job step information for jobs managed by Slurm.  
`squeue <options>`  
`squeue -u username`  
`squeue -j jobid`  
`squeue -p purley-cpu`  
**Exmaple**
```
[blao@x86-logon01 ~]$ squeue 
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
17810 inspur-gp step.bat      xzj  R 3-03:15:24      1 inspur-gpu02
17921 inspur-gp test.bat      xzj  R 1-19:45:57      1 inspur-gpu02
17931 purley-cp  test.sh feirui20  R    1:04:06      1 purley-x86-cpu01 
```             
Information interprets  
JOBID: ID of job.  
PARTITION: partition name used of the job.  
NAME: job name.  
USER: user name.  
ST: job state. R=running. PD=pending. CA=cancelled. CG=completing. CD=completed.  
TIME: time used by the job  
NODES: the actual number of nodes allocated to the job.  
NODESLIST: list of nodes allocated to the job or job step.  

To view more options of squeue:  
`squeue --help`

Individual Job Information  
`scontrol show job jobid`  
```
[blao@x86-logon01 ~]$ scontrol show job 17810  
JobId=17810 JobName=step.batch  
   UserId=xzj(10015) GroupId=xzj(10019) MCS_label=N/A  
   Priority=4294901731 Nice=0 Account=xzj QOS=normal  
   JobState=RUNNING Reason=None Dependency=(null)  
   Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0  
   RunTime=3-03:41:48 TimeLimit=UNLIMITED TimeMin=N/A  
   SubmitTime=2020-09-23T11:16:25 EligibleTime=2020-09-23T11:16:25  
   AccrueTime=2020-09-23T11:16:25  
   StartTime=2020-09-23T11:16:26 EndTime=Unknown Deadline=N/A  
   PreemptTime=None SuspendTime=None SecsPreSuspend=0  
   LastSchedEval=2020-09-23T11:16:26  
   Partition=inspur-gpu-opa AllocNode:Sid=x86-logon01:339306  
   ReqNodeList=(null) ExcNodeList=(null)  
   NodeList=inspur-gpu02  
   BatchHost=inspur-gpu02  
   NumNodes=1 NumCPUs=1 NumTasks=1 CPUs/Task=1 ReqB:S:C:T=0:0:*:*  
   TRES=cpu=1,mem=3001M,node=1,billing=1,gres/gpu=1  
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*  
   MinCPUsNode=1 MinMemoryNode=3001M MinTmpDiskNode=0  
   Features=(null) DelayBoot=00:00:00  
   OverSubscribe=OK Contiguous=0 Licenses=(null) Network=(null)  
   Command=/home/xzj/STEP/AI/step.batch  
   WorkDir=/home/xzj/STEP/AI  
   StdErr=/home/xzj/STEP/AI/step.out  
   StdIn=/dev/null  
   StdOut=/home/xzj/STEP/AI/step.out  
   Power=  
   TresPerNode=gpu:1  
```
## Job Request  
SLURM needs to know two things from you:    
### Resource requirement. How many nodes and how long you need them for.  
### What to run.  
* You cannot submit an application directly to SLURM. Instead, SLURM executes on your behalf a list of shell commands.  
* In `batch mode`. SLURM executes a `jobscript` which contains the commands.  
* In `interactive mode`, type in commands just like when you log in.  
* These commands can include launching programs onto compute nodes assigned for the job.   

## Jobscripts
### A `jobscript` is a bash or csh script.  
### sbatch interprets directives in the script, which are written as comments and not executed.  
*	Directive lines start with `#SBATCH`
*	These are quivalent to sabtch command-line arguments.
*	Directives are usually more convenient and reproducible than command-line arguments. Put your resource request into the `jobscript`.  
The `jobscript` will execute on one of the allocated compute node   
`#SBATCH directives are comments, so only subsequent commands are executed.`  

### Common sbatch directives     
**Example jobscript (hostname.sh)**
```
#!/bin/bash  
#SBATCH --job-name=myjob  #makes it easier to find in squeue  
#SBATCH --partition=purley-cpu # partition name  
#SBATCH --nodes=2 # number of nodes  
#SBATCH --tasks-per-node=1 #processes per node  
#SBATCH --cpus-per-task=1 #cores per process  
#SBATCH --time=00:05:00 # walltime requested  
#SBATCH --export=NONE # start with a clean environment.  This improves reproducibility and avoids contamination of the environment.  
#The next line is executed on the compute node  
hostname  
```
### Launch the job with sbatch:  
`sbatch hostname.sh`

### To view more options of sbatch:  
`sbatch --help`

### SLURM Output  
Standard output and standard error from your jobscript are collected by SLURM, and written to a file in the directory you submitted the job when the job finishes/dies.  
`slurm-jobid.out`  
`cat slurm-jobid.out`  

## Serial python example (hello-serial.sh)  
This job script will run on a single core of SHAO’s cluster for up to 5 minutes:  
```
#!/bin/bash 
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
```

The script can be submitted to the scheduler with:    
`sbatch hello-serial.sh`  

## Lauching Paralle Programs
Parallel applications are launched using srun.
The arguments determine the parallelism:  
-N   number of nodes  
-n   number of tasks (for process parallelism e.g. MPI)  
-c   cores per task (for thread parallelism e.g. OpenMP)  
While these are already provided in the SBATCH directives, they should be provided again in the srun arguments.  

**OpenMP example (hello-openmp.sh)**
This will run 1 process with 24 threads on 1 purley-cpu compute node, using 24 cores for up to 5 minutes:  
```
#!/bin/bash   
#SBATCH --job-name=hello-openmp  
#SBATCH --partition=purley-cpu  
#SBATCH --nodes=1  
#SBATCH --tasks-per-node=1  
#SBATCH --cpus-per-task=24  
#SBATCH --time=00:05:00  
#SBATCH --export=NONE  

# set OpenMP environment variables  
export OMP_NUM_THREADS=24  
export OMP_PLACES=cores  
export OMP_PROC_BIND=close  

# launch OpenMP program  
srun --export=all -n 1 -c ${OMP_NUM_THREADS} ./hello-openmp-gcc  
```
The program can be compiled and the script can be submitted to the scheduler with:  
`cd hello-openmp`  
`make`    
`sbatch hello-openmp.sh`  

**MPI example**   
This will run 24 MPI processes on 1 node on purley-cpu:  
```
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
```
The script can be submitted to the scheduler with:  
`cd hello-mpi`  
`module load mpich/cpu-3.2.1-gcc-7.3.0`  
`make`  
`sbatch hello-mpi.sh`  


## GPU Example (hello-gpu.sh)    
This will run one gpu device on a GPU node:    
```
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
```
The script can be submitted to the scheduler with:  
`cd hello-gpu`
`module load cuda/9.0`
`nvcc -o hello-gpu hello-gpu.cu`
`sbatch hello-gpu.sh`


All scripts can be downloaded from this git repository:   
https://github.com/lao19881213/Introductory-CSRC-P

## Interactive Jobs  
Sometimes you need them:  
*	Debugging  
*	Compiling  
*	Pre/post-processing  
Use salloc instead of sbatch.  
You still need srun to place jobs onto compute nodes.  
`#SBATCH directives must be included as command line arguments.`

**For example (compiling):**  
`salloc --tasks=16 --partition purley-cpu --time=00:10:00`
`srun make -j 16`

Run hello-serial.py interactively on a purley-cpu compute node.    

Start an interactive session (you may need to wait while it is in the queue):      

`salloc --partition=purley-cpu --tasks=1 --time=00:10:00`

Prepare the environment:    
`module use /home/app/modulefiles`  
`module load python/cpu-3.7.4`  

Launch the program:    
`srun --export=all -n 1 python3 hello-serial.py`  
Exit the interactive session:    
`exit`


You can also run a hello-serial interactively only using srun:
Prepare the environment:  
`module use /home/app/modulefiles`  
`module load python/cpu-3.7.4`  

Launch the program:   
`srun --export=all -N 1 -n 1 -p purley-cpu python3 hello-serial.py`

## Job cancel
`scancel JOBID`

