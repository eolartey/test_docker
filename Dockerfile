FROM ubuntu:latest
ENV REFRESHED_AT 2022-06-01

#Download Linux support tools
RUN apt-get update && \
apt-get clean && \
apt-get install -y autoconf && \
apt-get install -y libtool && \
apt-get install -y \
build-essential \
wget \
curl \
git

#Set up a development tools directory
WORKDIR /home/dev
ADD . /home/dev

RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 | tar -xj

#Set up the compiler path
ENV PATH $PATH:/home/dev/gcc-arm-none-eabi-10.3-2021.10/bin

WORKDIR /home/app

#Install and configure CppUTest
WORKDIR /home/cpputest
RUN git clone --depth 1 --branch v4.0 https://github.com/cpputest/cpputest.git .
RUN autoreconf . -i
RUN ./configure
RUN make install
ENV CPPUTEST_HOME=/home/cpputest
