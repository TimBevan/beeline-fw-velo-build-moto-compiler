FROM ubuntu:16.04
MAINTAINER Chetan Padia <chet@beeline.co>

RUN apt-key update && \
    sh -c 'curl -sL https://deb.nodesource.com/setup_6.x | bash -' && \
    apt-get update && \
    apt-get install -y curl git unzip bzip2 build-essential gcc-multilib libssl-dev srecord openocd pkg-config nodejs s3cmd python && \
    apt-get clean all

# NRF51 SDK v10
ADD https://developer.nordicsemi.com/nRF5_SDK/nRF51_SDK_v10.x.x/nRF51_SDK_10.0.0_dc26b5e.zip /nRF51_SDK_10.0.0_dc26b5e.zip
RUN mkdir -p /nrf51/nRF51_SDK_10.0.0 && unzip -q ../../nRF51_SDK_10.0.0_dc26b5e.zip -d /nrf51/nRF51_SDK_10.0.0

# Download and install ARM toolchain used with Moto - more recent than the SDK
RUN curl -SL https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2018q2/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2?revision=bc2c96c0-14b5-4bb4-9f18-bceb4050fee7?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2018-q2-update > /tmp/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 && \
	tar xvjf /tmp/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2 -C /usr/local/ && \
	rm /tmp/gcc-arm-none-eabi-7-2018-q2-update-linux.tar.bz2
ENV PATH="${PATH}:/usr/local/gcc-arm-none-eabi-7-2018-q2-update/bin"
