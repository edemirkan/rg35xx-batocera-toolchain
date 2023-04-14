FROM docker.io/debian:bookworm-slim

ARG BATOCERA_SDK_VER=rg35xx_batocera_sdk_alpha_0.5
ARG BATOCERA_BUILDROOT_URL=https://github.com/rg35xx-cfw/rg35xx-cfw.github.io/releases/download/${BATOCERA_SDK_VER}/arm-buildroot-linux-gnueabihf_sdk-buildroot.tar.gz
ARG DEST_BUILDROOT_PATH=/opt/rg35xx
ARG DEBIAN_FRONTEND=noninteractive

    # Prep base image
RUN apt-get update \
    && apt-get install -y make gcc g++ cmake python3\
    file wget cpio zip unzip rsync bc git autoconf curl\  
    && apt-get -y autoremove \
    && apt-get -y clean 

    # Unpack buildroot
RUN curl -SL ${BATOCERA_BUILDROOT_URL} | tar -xzC /opt \
    # move all under to /opt/rg35xx
    && ls -Q /opt | xargs -i mv /opt/{} ${DEST_BUILDROOT_PATH} \
    # and relocate
    && ${DEST_BUILDROOT_PATH}/relocate-sdk.sh

COPY ./build /root/build/
WORKDIR /root/build/

# Build and install SDL
RUN cat ./setup-env.sh >> /root/.bashrc \
   # Clean up
   && rm -rfd /root/build
WORKDIR /root/workspace/

CMD ["/bin/bash"]