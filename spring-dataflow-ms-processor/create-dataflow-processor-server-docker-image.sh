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

if [ -e dataflow-ms-flow-centric-process-poc.jar ]; then
	rm -f dataflow-ms-flow-centric-process-poc.jar
fi

cp $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-process-poc/target/dataflow-ms-flow-centric-process-poc-*.jar ./dataflow-ms-flow-centric-process-poc.jar 

if [ -e ./dataflow-ms-flow-centric-process-poc.jar   ]; then

docker --debug image build --rm . -t $DOCKER_IMAGE_USER/spring-cloud-dataflow-processor-server:$SERVER_RELEASE

rm dataflow-ms-flow-centric-process-poc.jar

else
	echo "Unable to copy file $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-process-poc/target/dataflow-ms-flow-centric-process-poc-*.jar"
	echo "From  folder $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-process-poc/target, listed as:"
	echo "Files: $(ls $JAVA_PROJECT_FOLDER/dataflow-ms-flow-centric-process-poc/target)"
	exit 1
fi
