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

if [ -e dataflow-ms-flow-centric-process-poc.jar ]; then
	rm -f dataflow-ms-flow-centric-process-poc.jar
fi

ln -s $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-process-poc/target/dataflow-ms-flow-centric-process-poc-*.jar dataflow-ms-flow-centric-process-poc.jar 

docker --debug image build --rm . -t $DOCKER_IMAGE_USER/spring-cloud-dataflow-processor-server:$SERVER_RELEASE

rm dataflow-ms-flow-centric-process-poc.jar