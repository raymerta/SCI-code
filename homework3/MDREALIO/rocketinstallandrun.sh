#!/bin/bash

module purge
module load openmpi-1.8.4

cd $HOME
mkdir mdrealio
cd mdrealio
git clone https://github.com/JulianKunkel/md-real-io

# Get and install recent version of CMAKE
wget https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz
tar -xvf cmake-3.7.2.tar.gz

cd cmake-3.7.2/
./bootstrap
./configure --prefix=$HOME/mdrealio/cmakeinstall
make
make install

# Get and install md-real-io
cd $HOME/mdrealio/md-real-io/
mkdir build
cd build
$HOME/mdrealio/cmakeinstall/bin/cmake ..
make

# Run md-real-io in your home directory on one node
cd src

srun  -N 1 -n 1 -t 00:10:00 ./md-real-io -i=posix -P=1 -D=5 -I=3 -S=3900

mkdir /gpfs/rocket/scratch/$USER
cp md-real-io /gpfs/rocket/scratch/$USER
cd /gpfs/rocket/scratch/$USER
srun  -N 1 -n 1 -t 00:10:00 ./md-real-io -i=posix -P=1 -D=5 -I=3 -S=3900

# Clean up scratch space
cd $HOME
rm -rf /gpfs/rocket/scratch/$USER



