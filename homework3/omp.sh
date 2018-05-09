#!/bin/bash

#SBATCH -N 2
#SBATCH --sockets-per-node=2
#SBATCH --cores-per-socket=10
#SBATCH --threads-per-core=1
#SBATCH -t 00:10:00

module purge
module load openmpi-2.0.1

gcc -fopenmp omp_hello.c -o omp_hello

srun omp_hello -a
sleep 30
