/***********************************************
*  Race_condition.c
*  OpenMP Example - Race Condition
***********************************************/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main ( argc , argv )
int argc;
char **argv;
{

int tid,i;
int a[100] = {[0 ... 99] = 1};
int b[100] = {[0 ... 99] = 1};

/* Fork a team of threads giving them their own copies of variables */
#pragma omp parallel private (tid)
  {

  tid = omp_get_thread_num();
//  nthreads = omp_get_num_threads();
  #pragma omp for
  for (i=0; i<100-1; i++){
    a[i] = a[i+1] + b[i];
    printf("a[%d]=%d \n",i,a[i]);
  }

  }

return 0;

}




