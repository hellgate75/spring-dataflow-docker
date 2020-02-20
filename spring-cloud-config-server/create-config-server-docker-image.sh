#!/bin/sh

if [ "" = "$CONFIG_SERVER_RELEASE" ]; then
	CONFIG_SERVER_RELEASE="1.0.0"
fi

if [ "" = "$DOCKER_IMAGE_USER" ]; then
	DOCKER_IMAGE_USER=hellgate75
fi

if [ "" = "$JAVA_PROJECT_FOLDER" ]; then
	JAVA_PROJECT_FOLDER="../../.."
fi

if [ -e dataflow-ms-config-server.jar ]; then
	rm -f dataflow-ms-config-server.jar
fi

ln -s $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-config-server/target/dataflow-ms-flow-centric-config-server-*.jar dataflow-ms-config-server.jar 

docker --debug image build --rm . -t $DOCKER_IMAGE_USER/spring-cloud-config-server:$CONFIG_SERVER_RELEASE

rm -f dataflow-ms-config-server.jar