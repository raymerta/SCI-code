#!/bin/bash

#SBATCH -N 4
#SBATCH --ntasks-per-node=4

module purge
module load intel_parallel_studio_xe_2015

make -B all
make run_dgemm_example
