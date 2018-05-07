#include <mpi.h>
#include <stdio.h> 

int main(int argc, char** argv) {
	// initialize MPI environment
	MPI_Init(NULL, NULL);

	// get number of processes
	int world_size;
	MPI_Comm_size(MPI_COMM_WORLD, &world_size);

	// get rank of the process
	int world_rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

	// get name of the processor
	char processor_name[MPI_MAX_PROCESSOR_NAME];
	int name_len;
	MPI_Get_processor_name(processor_name, &name_len);

	printf("Hello world from processor %s, rank %d out of %d processors \n",processor_name, world_rank, world_size);

	MPI_Finalize();
}


