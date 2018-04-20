#!/bin/bash

# A Bash script to compile the peakflops program for use on the Xeon 
# chips on Rocket
rm -f *.o


# compile helloworld code
ifort -c -offload-attribute-target=mic -O3 -opt-threads-per-core=2  -openmp -xAVX -align rec16byte  -vec-report3  ./PeakFlopsPhi.f -o ./PeakFlopsPhi.o

ifort ./PeakFlopsPhi.o -openmp -o ./PeakFlopsPhi.out

