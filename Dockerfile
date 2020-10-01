FROM gcc:10

RUN apt-get update && apt-get install -y git wget curl

# Example taken from https://github.com/Rikorose/gcc-cmake/blob/master/gcc-10/Dockerfile
# Install CMake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.18.2/cmake-3.18.2-Linux-x86_64.sh \
	-q -O /tmp/cmake-install.sh \
	&& mkdir /usr/bin/cmake \
	&& bash /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
	&& rm /tmp/cmake-install.sh


# Install Python
RUN apt-get install -y python3.7-dev python2.7-dev
# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o tmp/get-pip.py \
	&& python3 /tmp/get-pip.py \
	&& rm tmp/get-pip.py

# Install pytest
RUN pip3 install --no-cache-dir pytest


# Example taken from https://github.com/pblischak/boost-docker-test/blob/master/Dockerfile
# Install Boost
RUN cd /home && wget http://downloads.sourceforge.net/project/boost/boost/1.74.0/boost_1_74_0.tar.gz \
	&& tar xfz boost_1_74_0.tar.gz \
	&& rm boost_1_74_0.tar.gz \
	&& cd boost_1_74_0 \
	&& ./bootstrap.sh --prefix=/usr/local --show-libraries \
	&& ./b2 install \ 
	&& cd /home \
	&& rm -rf boost_1_74_0
	 

ENV PATH="/usr/bin/cmake/bin:${PATH}"

# Useful notes for myself below:

# Extract a tar file with tar -xzvf archive.tar.gz
# Compress a tar file with tar -czvf name-of-archive.tar.gz /path/to/directory-or-file

# To extract a tar's components into a preexisting UnderTest folder use
# tar -xzvf UnderTest.tar.gz -C UnderTest --strip-components=1

# To run Docker with a name and keep it detached but alive run 
# docker run -d -it --name tester connorfuhrman/uarizona-ece275-tester:0.1

# To copy a file to that image run 
# docker cp underTest.tar.gz tester:home

# Workflow for this is shown below:
# docker run -d -it --name tester connorfuhrman/uarizona-ece275-tester:0.1
# docker cp UnderTest.tar.gz tester:home
# docker exec -it tester ./runtests.sh
# docker stop tester (to stop the process)
# docker rm tester (to remove)