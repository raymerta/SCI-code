#!/bin/bash

#SBATCH -N 1
#SBATCH --ntasks-per-node=8
#SBATCH -t 00:10:00

module purge
module load openmpi-2.0.1

gcc -fopenmp omp_hello.c -o omp_hello

start=$(($(date +%s%N)/1000000))

mpirun omp_hello 10

end=$(($(date +%s%N)/1000000))
duration=$(($end-$start))

echo $duration
