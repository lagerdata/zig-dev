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
	apt-get -y install build-essential llvm-11 cmake \
	llvm-11-dev clang-11 libclang-11-dev libclang-cpp11 \
	libclang-cpp11-dev git lld-11 liblld-11-dev && \
	rm -rf /var/apt/lists/*


