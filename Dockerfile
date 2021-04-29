# Requires at least 16GB of RAM for container

# Initial setup:
# docker build -t zigdev .
# docker volume create zigdev
# docker run --rm -it -v zigdev:/zigdev zigdev
# cd /zigdev
# git clone https://github.com/ziglang/zig.git
# cd zig
# mkdir build
# cd build
# cmake ..
# make -j16 install

# subsequently:
# docker run --rm -it -v zigdev:/zigdev zigdev
# cd /zigdev/zig
# git pull
# cd build
# make -j16 install
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get -y install wget gpg && \
	wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - && \
	apt-get -y remove wget gpg && \
	printf "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-12 main\ndeb-src http://apt.llvm.org/focal/ llvm-toolchain-focal-12 main" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get -y install build-essential llvm-12 cmake \
	llvm-12-dev clang-12 libclang-12-dev libclang-cpp12 \
	libclang-cpp12-dev git lld-12 liblld-12-dev && \
	rm -rf /var/apt/lists/*


ENV PATH $PATH:/zigdev/zig/build/bin