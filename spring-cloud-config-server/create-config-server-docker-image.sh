#!/bin/sh
if [[ "" == "$CONFIG_SERVER_RELEASE" ]]; then
	CONFIG_SERVER_RELEASE="1.0.0"
fi
if [[ "" == "$DOCKERHUB_USER" ]]; then
	DOCKERHUB_USER=hellgate75
fi
docker --debug image build --rm . -t $DOCKERHUB_USER/spring-cloud-config-server:$CONFIG_SERVER_RELEASE
