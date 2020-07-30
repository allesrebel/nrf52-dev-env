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
ARG NRF_TOOLCHAIN=https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2
RUN wget -P /tmp -q --show-progress $NRF_TOOLCHAIN
RUN tar -xvjf /tmp/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2

# Grab a copy of the SDK (Static, from nordic)
ARG NORDIC_SDK=https://www.nordicsemi.com/-/media/Software-and-other-downloads/SDKs/nRF5/Binaries/nRF5SDK17009d13099.zip
RUN wget -P /tmp -q --show-progress $NORDIC_SDK
RUN unzip /tmp/nRF5SDK17009d13099.zip -d .

# Set up Env Vars
ENV SDK_ROOT="/tmp/nRF5_SDK_17.0.0_9d13099"
ENV GNU_INSTALL_ROOT="/tmp/gcc-arm-none-eabi-9-2019-q4-major/bin/"
ENV GNU_VERSION="9.2019q4.major"

WORKDIR /opt/project/armgcc
CMD ["make"]
