FROM gcc:10

RUN apt-get update && apt-get install -y git wget

# Example taken from https://github.com/Rikorose/gcc-cmake/blob/master/gcc-10/Dockerfile

# Install CMake
RUN echo "Installing CMake from source" \
	&& wget https://github.com/Kitware/CMake/releases/download/v3.18.2/cmake-3.18.2-Linux-x86_64.sh \
	-q -O /tmp/cmake-install.sh \
	&& chmod u+x /tmp/cmake-install.sh \
	&& mkdir /usr/bin/cmake \
	&& /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
	&& rm /tmp/cmake-install.sh

# Example taken from https://github.com/pblischak/boost-docker-test/blob/master/Dockerfile

# Install Boost from https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.tar.bz2 
RUN cd /home && wget http://downloads.sourceforge.net/project/boost/boost/1.74.0/boost_1_74_0.tar.gz \
	&& tar xfz boost_1_74_0.tar.gz \
	&& rm boost_1_74_0.tar.gz \
	&& cd boost_1_74_0 \
	&& ./bootstrap.sh --prefix=/usr/local --show-libraries \
	&& ./b2 install
# Clean up out install 
RUN cd /home \
	&& rm -rf boost_1_74_0

FROM python:3.8
RUN pip install --no-cache-dir -v \
	pytest \
	os \ 
	shutil \ 
	subprocess \ 
	difflib \ 
	re \ 
	pprint
	 

ENV PATH="/usr/bin/cmake/bin:${PATH}"
