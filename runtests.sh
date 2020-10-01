#!/bin/bash

# We assume that there is a tar file UnderTest.tar.gz in /home

# Navigate to home and make a directory "UnderTest"
cd /home && mkdir UnderTest

# Untar the files and strip them into the UnderTest directory
tar -xzvf UnderTest.tar.gz -C UnderTest --strip-components=1

# Remove the compressed tar file
rm UnderTest.tar.gz

# Move to the UnderTest directory
cd UnderTest

# Execute CMake
echo "Executing CMake to generate build files for your project"
mkdir build && cd build
cmake .. 

# Execute make
echo "Executing make to compile your program(s)"
make -j2

# Move to the Tester directory and run tests
cd Tester && ctest -V