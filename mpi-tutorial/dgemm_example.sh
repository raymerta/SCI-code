#!/bin/bash

#SBATCH -N 4
#SBATCH --ntasks-per-node=4

module purge
module load intel_parallel_studio_xe_2015

export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

icc -mkl dgemm_example.c -o dgemm_example
