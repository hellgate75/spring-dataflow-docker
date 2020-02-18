#!/bin/sh
apt-get update &&\
 apt-get install -y vim iputils-* wget curl && \
  apt-get clean all && \
  rm -rf /var/lib/apt/lists/* 
