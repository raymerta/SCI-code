#!/bin/bash

module purge
module load openmpi-1.8.4

cd $HOME
cd mdrealio


# Get and install md-real-io
cd $HOME/mdrealio/md-real-io/build

# Run md-real-io in your home directory on one node
cd src

srun  -N 1 -n 1 -t 00:10:00 ./md-real-io -i=posix -P=1 -D=5 -I=3 -S=3900



