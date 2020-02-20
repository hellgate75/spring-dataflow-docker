#!/bin/sh
if [ "" = "$SERVER_RELEASE" ]; then
	SERVER_RELEASE="1.0.0-flow-centric"
fi

if [ "" = "$DOCKER_IMAGE_USER" ]; then
	DOCKER_IMAGE_USER=hellgate75
fi

if [ "" = "$JAVA_PROJECT_FOLDER" ]; then
	JAVA_PROJECT_FOLDER="../../.."
fi

if [ -e dataflow-ms-flow-centric-sink-poc.jar ]; then
	rm -f dataflow-ms-flow-centric-sink-poc.jar
fi

cp $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-sink-poc/target/dataflow-ms-flow-centric-sink-poc-*.jar dataflow-ms-flow-centric-sink-poc.jar 

docker --debug image build --rm . -t $DOCKER_IMAGE_USER/spring-cloud-dataflow-sink-server:$SERVER_RELEASE

rm dataflow-ms-flow-centric-sink-poc.jar