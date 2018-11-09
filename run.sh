#!/usr/bin/env bash

xhost +local:docker

CONTAINER_EXIST=`docker ps -a --format "{{.Image}}" | grep inspectrum`

if [ $CONTAINER_EXIST ]; then
    docker start inspectrum
else
    docker run --rm -d \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v `echo $HOME`:/inspectrum \
        -e DISPLAY=unix$DISPLAY \
        --name inspectrum \
        inspectrum
fi