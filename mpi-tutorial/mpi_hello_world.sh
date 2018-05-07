#!/bin/bash

module purge
module load openmpi-2.0.1

mpicc mpi_hello_world.c -o mpi_hello_world
