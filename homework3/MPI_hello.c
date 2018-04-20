#include <stdio.h>
#include <mpi.h>
int main(int argc, char ** argv) {
int size,rank;
int length;
char name[80];

MPI_Init(&argc, &argv);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
MPI_Comm_size(MPI_COMM_WORLD,&size);
MPI_Get_processor_name(name,&length);
if(rank==0){
printf(
"Hello World MPI! Host name: %s Host size: %d nodes \n", name, size);
}
printf(
"Hello World MPI! Process %d out of %d on Host: %s\n", rank, size, name);
MPI_Finalize();
return 0;
}
