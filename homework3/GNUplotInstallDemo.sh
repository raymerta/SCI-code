#!/bin/bash

# A script to install GNUplot on Rocket 
# More information at
# http://gnuplot.sourceforge.net/
# http://www.gnuplotting.org/
# http://people.duke.edu/~hpgavin/gnuplot.html
# http://www.phyast.pitt.edu/~zov1/gnuplot/html/intro.html
# http://www2.yukawa.kyoto-u.ac.jp/~akira.ohnishi/Lib/gnuplot.html
# http://physics.ucsc.edu/~medling/programming/gnuplot_tutorial_1/index.html

cd $HOME
module purge
module load gcc-4.8.1

# Get and install GNUplot then test it 
export GNUplotDIR=GnuPlot
mkdir $GNUplotDIR
cd $GNUplotDIR
wget "http://sourceforge.net/projects/gnuplot/files/gnuplot/5.0.0/gnuplot-5.0.0.tar.gz/download" -O gnuplot-5.0.0.tar.gz
tar -xvf gnuplot-5.0.0.tar.gz
cd gnuplot-5.0.0 
./configure --prefix=$HOME/$GNUplotDIR/install 
# Build package
make 
# Install package
make install
# Setup Paths
export PATH=$HOME/$GNUplotDIR/install/bin:$PATH
# Test Examples to ensure GNUplot is working 
# Go up one directory
cd ..
# Make example directory
mkdir example
# Go into example directory
cd example
wget http://www.gnuplotting.org/data/plotting_data1.dat
# create a gnuplot script file
touch plot.p
echo '# Gnuplot script file for plotting data in file "plotting_data1.dat"' >> plot.p
echo '# This file is called   plot.p ' >> plot.p
echo '# This is based on force.p at http://people.duke.edu/~hpgavin/gnuplot.html' >> plot.p 
echo 'set   autoscale                        # scale axes automatically' >> plot.p
echo 'unset log                              # remove any log-scaling' >> plot.p
echo 'unset label                            # remove any previous labels' >> plot.p 
echo 'set xtic auto                          # set xtics automatically' >> plot.p
echo 'set ytic auto                          # set ytics automatically' >> plot.p
echo 'set title " Example Graph "' >> plot.p
echo 'set xlabel " X "' >> plot.p
echo 'set ylabel " Y "' >> plot.p
echo 'set terminal eps                       # set output format to eps' >> plot.p
echo 'set output "output.eps"                # set output filename' >> plot.p
echo 'plot "plotting_data1.dat" using 1:2 title "Data" with linespoints' >> plot.p
# Make example plot
gnuplot>load 'plot.p' 
