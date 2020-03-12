# Grab the shell we want to use...
FROM ubuntu:latest

# before doing anything let's update the image as needed
USER root

ARG DEBIAN_FRONTEND=noninteractive

# Update Repos for basic stuff
RUN   apt-get update && apt-get -y install \
      vim   \
      git   \
      wget  \
      python \
      unzip \
      make \
      srecord

# Install the Toolchain
WORKDIR /tmp
ARG NRF_TOOLCHAIN=https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2
RUN wget -P /tmp -q --show-progress $NRF_TOOLCHAIN
RUN tar -xvjf /tmp/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2

# Grab a copy of the SDK (Static, from nordic)
ARG NORDIC_SDK=https://www.nordicsemi.com/-/media/Software-and-other-downloads/SDKs/nRF5/Binaries/nRF5SDK160098a08e2.zip
RUN wget -P /tmp -q --show-progress $NORDIC_SDK
RUN unzip /tmp/nRF5SDK160098a08e2.zip -d nRF5_SDK_16.0.0

# Set up Env Vars
ENV SDK_ROOT="/tmp/nRF5_SDK_16.0.0"
ENV GNU_INSTALL_ROOT="/tmp/gcc-arm-none-eabi-7-2018-q2-update/bin/"
ENV GNU_VERSION="7.3.1"

WORKDIR /opt/project/armgcc
CMD ["make"]
