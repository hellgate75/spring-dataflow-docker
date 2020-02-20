#!/bin/sh -e
if [ "" = "$SERVER_RELEASE" ]; then
	SERVER_RELEASE="1.0.0-flow-centric"
fi

if [ "" = "$DOCKER_IMAGE_USER" ]; then
	DOCKER_IMAGE_USER=hellgate75
fi

if [ "" = "$JAVA_PROJECT_FOLDER" ]; then
	JAVA_PROJECT_FOLDER="../../.."
fi

if [ -e ./dataflow-ms-flow-centric-source-poc.jar ]; then
	rm -f ./dataflow-ms-flow-centric-source-poc.jar
fi

cp $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-source-poc/target/dataflow-ms-flow-centric-source-poc-*.jar ./dataflow-ms-flow-centric-source-poc.jar 

if [ -e ./dataflow-ms-flow-centric-source-poc.jar   ]; then

docker --debug image build --rm . -t $DOCKER_IMAGE_USER/spring-cloud-dataflow-source-server:$SERVER_RELEASE

rm dataflow-ms-flow-centric-source-poc.jar

else
	echo "Unable to copy file $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-source-poc/target/dataflow-ms-flow-centric-source-poc-*.jar"
	echo "From  folder $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-source-poc/target, listed as:"
	echo "Files: $(ls $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-source-poc/target)"
	exit 1
fi
