#!/bin/bash
module purge
module load openmpi-1.8.4

# Run the code in your home directory on Rocket 
cd $HOME/iortest/bin
srun -N 1 -c 1 -t 00:10:00 ./ior

# Run the code in scratch directory
mkdir /gpfs/rocket/scratch/$USER
cp -r $HOME/iortest /gpfs/rocket/scratch/$USER
cd /gpfs/rocket/scratch/$USER/ior/bin
srun -N 1 -c 1 -t 00:10:00 ./ior
# Clean up scratch space
cd $HOME
rm -rf /gpfs/rocket/scratch/$USER


