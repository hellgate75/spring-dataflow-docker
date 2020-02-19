#!/bin/sh

if [ "" = "$CONFIG_SERVER_RELEASE" ]; then
	CONFIG_SERVER_RELEASE="1.0.0"
fi
if [ "" = "$DOCKERHUB_USER" ]; then
	DOCKERHUB_USER=hellgate75
fi
if [ ! -e ./dataflow-ms-config-server.jar ]; then
	curl -sL https://ftorelli-software-compliance-repository.s3-eu-west-1.amazonaws.com/docker-machines/spring-dataflow/dataflow-ms-config-server.jar -o ./dataflow-ms-config-server.jar
fi
docker --debug image build --rm . -t $DOCKERHUB_USER/spring-cloud-config-server:$CONFIG_SERVER_RELEASE
