#!/bin/bash

#SBATCH -N 4
#SBATCH --ntasks-per-node=4

module purge
module load intel_parallel_studio_xe_2015

export LANG=C
icc -mkl dgemm_example.c
