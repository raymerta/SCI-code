#!/bin/bash

# A script to compile the example C programs
# This should work on Rocket and on Vedur
# Modify appropriately to use Juur

module purge
module load openmpi-2.0.1
gcc -fopenmp omp_hello.c -o omp_hello
gcc -fopenmp Race_condition.c -o Race_condition
mpicc MPI_hello.c -o mpi_hello
mpicc mpi_helloBsend.c -o mpi_Bsend
mpicc mpi_helloIsend.c -o mpi_Isend
mpicc pingpong.c -o pingpong
