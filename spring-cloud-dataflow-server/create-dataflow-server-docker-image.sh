#!/bin/sh
if [[ "" == "$SERVER_RELEASE" ]]; then
	SERVER_RELEASE="1.0.0"
fi
if [[ "" == "$DOCKERHUB_USER" ]]; then
	DOCKERHUB_USER=hellgate75
fi
docker --debug image build --rm . -t $DOCKERHUB_USER/spring-cloud-dataflow-server:$SERVER_RELEASE
