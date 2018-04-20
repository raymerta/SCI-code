/******************************************************************************
* FILE: pingpong2.c
* DESCRIPTION:
*   MPI tutorial example ping pong code. This needs to be run with 2
*   or more processes.
*   Reference: http://www.cac.cornell.edu/VW/MPIoneSided/pingpong.aspx
*   Reference due to Indrek Jentson
*   http://www2.imm.dtu.dk/courses/FortranMPI/MPI/Labs/Lab2/pingpong.f90
* AUTHOR: 
* LAST REVISED: 
******************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"
#define MASTER 0

int main ( argc , argv )
int argc;
char **argv;
{
int size,rank;
int fsize;
MPI_Status status;
MPI_Init ( &argc , &argv );
MPI_Comm_rank( MPI_COMM_WORLD, &rank);
MPI_Comm_size( MPI_COMM_WORLD, &size);
int i,j,k,rep;
int *a;

double time_start,time_end;
double min_time=10000000.0;
double max_time=0.0;
double time=0.0;
int maxrep=1;
//200000= 200*1000
a=(int *)calloc( 200000 ,sizeof(int) );
if (a==NULL) {
printf("Memory allocation for a failed on rank %d \n",rank);
}

// commented out to prevent excessive output on many ranks
// printf("My rank is %d \n",rank);
for(i=0;i<=200;i+=50)
{
	fsize=1000*i;
	if(i==0)
	{
		fsize=1000;
	}
	if(rank==0)
	{
          for(k=0; k<(size-1); k++)
             {	
                MPI_Barrier(MPI_COMM_WORLD);
		for(j=0;j<fsize;j++)
		{
			a[j]=1;
		}
		time_start=MPI_Wtime();
                for(rep=0; rep<maxrep; rep++)
                {
		   MPI_Send(a,fsize,MPI_INT,k+1,4,MPI_COMM_WORLD);
		   MPI_Recv(a,fsize,MPI_INT,k+1,4,MPI_COMM_WORLD,&status);
                }
		time_end=MPI_Wtime();
		time=time_end-time_start;
                if(time<min_time)
                {
                    min_time=time;
                }
                if(time>max_time)
                {
                   max_time=time;
                }
                MPI_Barrier(MPI_COMM_WORLD);
            }
            min_time=min_time/maxrep;
            max_time=max_time/maxrep;
            printf("Minimum time needed to send-recv %d integers is: %f \n",fsize,min_time);
            printf("Maximum time needed to send-recv %d integers is: %f \n",fsize,max_time);
	}
	else
	{
          for(k=0; k<(size-1); k++)
           {
            MPI_Barrier(MPI_COMM_WORLD);
            if(rank==(k+1))
              {
               for(rep=0; rep<maxrep; rep++)
               {
		  MPI_Recv(a,fsize,MPI_INT,0,4,MPI_COMM_WORLD,&status);
		  for(j=0;j<fsize;j++)
		  {
			a[j]=2;
		  }
		  MPI_Send(a,fsize,MPI_INT,0,4,MPI_COMM_WORLD);
               }
             }
             MPI_Barrier(MPI_COMM_WORLD);
	}
      }
}
free(a);
MPI_Finalize ();
return 0;

}
 

