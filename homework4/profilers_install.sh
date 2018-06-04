#!/bin/bash

# A script to build and install profilers on Rocket
# The profilers considered are IPM

# Load appropriate modules
module purge
module load intel_parallel_studio_xe_2015 
module load zlib-1.2.6
module load libpng-1.5.10

# Make sure include directories for zlib and libpng can be found
# This is needed by ploticus
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/storage/software/libpng-1.5.10/include/
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/storage/software/zlib-1.2.6/include/
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH

# Get and install PAPI
# http://icl.cs.utk.edu/papi/
cd $HOME
export PROFILINGDIR=profilingexamples
mkdir $PROFILINGDIR
cd $PROFILINGDIR
export PAPIDIR=papi
mkdir $PAPIDIR
cd $PAPIDIR
wget icl.cs.utk.edu/projects/papi/downloads/papi-5.5.1.tar.gz
tar -xvf papi-5.5.1.tar.gz
cd papi-5.5.1
cd src
./configure --prefix=$HOME/$PROFILINGDIR/$PAPIDIR/install 
make
make install
export LIBRARY_PATH=$HOME/$PROFILINGDIR/$PAPIDIR/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/$PROFILINGDIR/$PAPIDIR/install/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$HOME/$PROFILINGDIR/$PAPIDIR/install/lib/pkgconfig:$PKG_CONFIG_PATH
# Get and install Ploticus which is used by IPM
# http://ploticus.sourceforge.net/doc/download.html
cd $HOME
cd $PROFILINGDIR
export PLOTICUSDIR=ploticus
mkdir $PLOTICUSDIR
cd $PLOTICUSDIR
# Get source code
wget "http://sourceforge.net/projects/ploticus/files/ploticus/2.42/ploticus242_src.tar.gz/download" -O ploticus242_src.tar.gz
tar -xvf ploticus242_src.tar.gz
cd ploticus242
cd src
# modify installation options
sed '95 c GD16LIBS = -L/storage/software/libpng-1.5.10/lib -lpng -L/storage/software/zlib-1.2.6/lib -lz' Makefile > Makefile2
sed "143 c INSTALLBIN = $HOME/$PROFILINGDIR/$PLOTICUSDIR/install/bin" Makefile2 > Makefile
sed '150 c NOSVG = -DNOSVG ' Makefile > Makefile2
# remove unnecessary files
rm Makefile
mv Makefile2 Makefile
# Build 
make
# make installation directory for ploticus library since script does not do this
mkdir $HOME/$PROFILINGDIR/$PLOTICUSDIR/install
mkdir $HOME/$PROFILINGDIR/$PLOTICUSDIR/install/bin
make install

# Make sure that the ploticus binary file can be found by ipm_parse
export PATH=$PATH:$HOME/$PROFILINGDIR/$PLOTICUSDIR/install/bin

# Get and install IPM
# http://ipm-hpc.org/
# https://github.com/nerscadmin/ipm
# http://ipm-hpc.sourceforge.net/overview.html
cd $HOME
cd $PROFILINGDIR
export IPMDIR=ipm
mkdir $IPMDIR
cd $IPMDIR
git clone https://github.com/nerscadmin/IPM.git
cd IPM
#autoreconf -f -i
./bootstrap.sh
./configure  --prefix=$HOME/$PROFILINGDIR/$IPMDIR/install --with-papi=$HOME/$PROFILINGDIR/$PAPIDIR/install --enable-static
make
make install
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/$PROFILINGDIR/$IPMDIR/install/lib
# Get and install Parallel 2D FFT library and then profile it
# more information at
cd $HOME
cd $PROFILINGDIR
export EXAMPLEDIR=example
mkdir $EXAMPLEDIR
cd $EXAMPLEDIR
wget www.2decomp.org/download/2decomp_fft-1.5.847.tar.gz
tar -xvf 2decomp_fft-1.5.847.tar.gz
cd 2decomp_fft
cd src
cp Makefile.inc.x86 Makefile.inc
cd ..
make
cd examples
cd timing
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
# Change size of problem
sed '9 c   integer, parameter :: nx=512, ny=512, nz=512' timing.f90 > timing2.f90
# remove unnecessary files
rm timing.f90
mv timing2.f90 timing.f90
# Build and run
make 
srun -t 00:10:00 --mem=40000 -N 2 -n 32 timing
# remove binary
make clean
# rebuild code with statically linked library for light weight profiling
sed "4 c LIBS =  -L$HOME/$PROFILINGDIR/$IPMDIR/install/lib/ -lipm -L../../lib -l2decomp_fft " Makefile > Makefile2
make -f Makefile2
# Run code with profiling enabled
srun -t 00:10:00 --mem=40000 -N 2 -n 32 timing
$HOME/$PROFILINGDIR/$IPMDIR/install/bin/ipm_parse -html *.xml
# next tar and zip the file so you can move it back to your own computer and view
# the profiled results or add a command to get the folder automatically emailed to you!
