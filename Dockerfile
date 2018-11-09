FROM debian:stable

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt upgrade -yf \
    && apt install -y git --no-install-recommends \
    && apt install -y qt5-default libfftw3-dev cmake pkg-config libliquid-dev build-essential \
    && apt-get -y clean && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /inspectrum

WORKDIR /opt

RUN git clone https://github.com/miek/inspectrum.git \
    && cd inspectrum \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install

ENV UNAME inspectrum

RUN export UNAME=$UNAME UID=1000 GID=1000 && \
    mkdir -p "/home/${UNAME}" && \
    echo "${UNAME}:x:${UID}:${GID}:${UNAME} User,,,:/home/${UNAME}:/bin/bash" >> /etc/passwd && \
    echo "${UNAME}:x:${UID}:" >> /etc/group && \
    mkdir -p /etc/sudoers.d && \
    echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${UNAME} && \
    chmod 0440 /etc/sudoers.d/${UNAME} && \
    chown ${UID}:${GID} -R /home/${UNAME} && \
    chown ${UID}:${GID} -R /${UNAME}

USER inspectrum

WORKDIR /inspectrum

ENTRYPOINT [ "inspectrum" ]