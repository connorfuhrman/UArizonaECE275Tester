FROM alpine:3.12

RUN apk -U upgrade

# Intall GCC and cmake along with many others
RUN apk add bash clang build-base gcc make git tar curl wget gdb musl musl-dev musl-dbg musl-utils emacs && \
	apk del cmake 

# Install CMake binaries
RUN apk add linux-headers openssl-dev
RUN cd /tmp && \
	wget https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4.tar.gz && \
	tar -xzf cmake-3.18.4.tar.gz && cd cmake-3.18.4 && ./bootstrap && make -j8 && make install && \
	cd /tmp && rm -fr cmake*

# Install Python
RUN apk add python2-dev python3-dev
# Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o tmp/get-pip.py \
	&& python3 /tmp/get-pip.py \
	&& rm tmp/get-pip.py

# Install pytest
RUN pip3 install --no-cache-dir pytest

# Install Boost from Alpine package manager
RUN apk add boost-dev

# Install GMP
RUN apk add gmp-dev

# Install pretty table formatter
RUN cd /tmp && \
	git clone https://github.com/seleznevae/libfort.git && \
	cd libfort && mkdir build && cd build && \
	cmake .. && make -j4 install && \
	rm -fr /tmp/libfort

# Add gensol.py to the root
#ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN pip3 install --no-cache-dir --upgrade --force-reinstall uarizona-ece275-outputfileTester
RUN pip3 freeze
ADD gensol.py /

RUN apk add zip gnuplot ffmpeg
	
ENV COMMANDARGS /tester/COMMANDARGS.txt

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