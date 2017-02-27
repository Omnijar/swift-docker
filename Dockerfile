
FROM ubuntu:16.04
MAINTAINER Omnijar Studio
LABEL Description="Ubuntu 16.04 image for execution of Swift applications."

USER root

# Set environment variables for image
ENV SWIFT_SNAPSHOT swift-3.0.2-RELEASE
ENV SWIFT_SNAPSHOT_LOWERCASE swift-3.0.2-release
ENV UBUNTU_VERSION ubuntu16.04
ENV UBUNTU_VERSION_NO_DOTS ubuntu1604
ENV HOME /root
ENV WORK_DIR /root

# Set WORKDIR
WORKDIR ${WORK_DIR}

# Linux OS utils & Swift libraries
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y \
  libicu-dev \
  libcurl4-openssl-dev \
  wget \
  && apt-get clean \
  && wget -q https://swift.org/builds/$SWIFT_SNAPSHOT_LOWERCASE/$UBUNTU_VERSION_NO_DOTS/$SWIFT_SNAPSHOT/$SWIFT_SNAPSHOT-$UBUNTU_VERSION.tar.gz \
  && tar xzvf $SWIFT_SNAPSHOT-$UBUNTU_VERSION.tar.gz $SWIFT_SNAPSHOT-$UBUNTU_VERSION/usr/lib/swift/linux \
  && rm $SWIFT_SNAPSHOT-$UBUNTU_VERSION.tar.gz \
  && find $SWIFT_SNAPSHOT-$UBUNTU_VERSION/usr/lib/swift/linux -type f ! -name '*.so' -delete \
  && rm -rf $SWIFT_SNAPSHOT-$UBUNTU_VERSION/usr/lib/swift/linux/*/ \
  && apt-get remove -y gcc cpp sgml-base icu-devtools libc6-dev binutils manpages-dev manpages wget pkg-config perl \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && apt-get autoremove -y

CMD /bin/bash
