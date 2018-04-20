#!/bin/bash

# A Bash script to compile the peakflops program for use on the Xeon 
# chips on Rocket
rm -f *.o


# compile helloworld code
ifort -c  -O3 -openmp -opt-threads-per-core=2 -xAVX -align rec16byte  -vec-report3  ./PeakFlops.f -o ./PeakFlops.o

ifort ./PeakFlops.o -openmp -o ./PeakFlops.out

