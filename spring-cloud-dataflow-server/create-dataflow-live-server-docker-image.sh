#!/bin/sh
if [ "" = "$SERVER_RELEASE" ]; then
	SERVER_RELEASE="1.0.0"
fi
if [ "" = "$DOCKER_IMAGE_USER" ]; then
	DOCKER_IMAGE_USER=hellgate75
fi
docker --debug image build --rm -f Dockerfile.live . -t $DOCKER_IMAGE_USER/spring-cloud-dataflow-live-server:$SERVER_RELEASE
