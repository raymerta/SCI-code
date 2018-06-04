#!/bin/bash

cd $HOME
cd profilingexamples
cd example
cd 2decomp_fft
cd examples
cd timing
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
module purge
module load intel_parallel_studio_xe_2015
module load zlib-1.2.6
module load libpng-1.5.10
make -f Makefile2
