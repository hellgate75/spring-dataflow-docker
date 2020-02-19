#!/bin/sh
if [ "" = "$SERVER_RELEASE" ]; then
	SERVER_RELEASE="1.0.0-flow-centric"
fi
if [ "" = "$DOCKER_IMAGE_USER" ]; then
	DOCKER_IMAGE_USER=hellgate75
fi
ln -s ../../../dataflow-ms-flow-centric-source-poc/target/dataflow-ms-flow-centric-source-poc-*.jar dataflow-ms-flow-centric-source-poc.jar 
docker --debug image build --rm . -t $DOCKER_IMAGE_USER/spring-cloud-dataflow-source-server:$SERVER_RELEASE
rm dataflow-ms-flow-centric-source-poc.jar