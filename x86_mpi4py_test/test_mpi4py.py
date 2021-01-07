from mpi4py import MPI

comm=MPI.COMM_WORLD
num_process=comm.Get_size()
rank=comm.Get_rank()
msg = "{0} hello".format(rank)
msg = comm.gather(msg,root=0)
if (0 == rank):
        print("root msg {0}".format(msg))
else:
        print ("slave msg {0}".format(msg))
print(rank, num_process)
