# Nordic Toolchain Docker Environment
This docker image generates the proper toolchain environment
for building and exporting binaries. Bare minimum to build an example
project from the SDK.

This image will be pulling in the latest arm-gcc toolchain
recommended by the SDK and attempt to build from source.

To update repository URLs, see docker file

# Image Contents
* [NRF52 16.0.0 SDK](https://infocenter.nordicsemi.com/index.jsp?topic=%2Fsdk_nrf5_v16.0.0%2Findex.html)
* [GNU ARM Toolchain 7.3.1](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads/7-2018-q2-update)
* vim, git, wget, python, unzip, make, srecord

# Pulling a Prebuilt image
If you're feeling lazy, feel free to just replace `hash` with 
`allesrebel/nrf52-dev-env:latest`. Note you'll need to first
pull the image with:

* `docker pull allesrebel/nrf52-dev-env:latest`

# Building the Docker Image
Make sure Docker is installed, see [Docker Install](https://docs.docker.com/install/)
In the directory of this repository, issue the `docker build -t nordic-builder.` command.

This will build the image for use. run `docker images` to make sure you now have an image
called `nordic-builder`

# Usage of Container

## Building a Specified Project
Running the image can be done with a standard run command with the
project to build with the `-v` command. The container expects the
project to be mounted to `/opt/` directory. For example:

* `docker run -v (Path to project):/opt/ nordic-builder`

## Interactively using the container
In situations where direct control of the toolchain is required
you can specify the `-it` arg and run bash directly. (Works during
start of the container or exec on a existing container)

### Location of Components
* /tmp/nRF5_SDK_16.0.0
* /tmp/gcc-arm-none-eabi-7-2018-q2-update
