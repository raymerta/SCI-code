#!/bin/bash
module purge
module load openmpi-1.8.4

#Make a directory and get the ior code
cd $HOME
mkdir ior
cd ior
wget https://github.com/LLNL/ior/archive/3.0.1.tar.gz
# Decompress the code, compile and install it
tar -xvf 3.0.1.tar.gz
cd ior-3.0.1
./bootstrap
./configure --prefix=$HOME/iortest
make
make install
# Run the code in your home directory on Vedur
cd $HOME/iortest/bin
srun -N 1 -c 1 -t 00:10:00 ./ior


