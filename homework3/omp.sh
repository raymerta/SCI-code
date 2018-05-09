#!/bin/bash

#The job should run on the testing partition
#SBATCH -p testing

#The name of the job is test_job
#SBATCH -J parallel_uname

#The job requires 4 compute nodes
#SBATCH -N 4

#The job requires 1 task per node
#SBATCH --ntasks-per-node=1

#The maximum walltime of the job is a half hour
#SBATCH -t 00:10:00

module purge
module load openmpi-2.0.1

gcc -fopenmp omp_hello.c -o omp_hello

srun omp_hello -a
sleep 30
