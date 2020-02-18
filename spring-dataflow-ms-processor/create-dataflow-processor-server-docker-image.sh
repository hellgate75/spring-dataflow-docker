#!/bin/sh
if [[ "" == "$SERVER_RELEASE" ]]; then
	SERVER_RELEASE="1.0.0-flow-centric"
fi
if [[ "" == "$DOCKERHUB_USER" ]]; then
	DOCKERHUB_USER=hellgate75
fi
ln -s ../../../dataflow-ms-flow-centric-process-poc/target/dataflow-ms-flow-centric-process-poc-*.jar dataflow-ms-flow-centric-process-poc.jar 
docker --debug image build --rm . -t $DOCKERHUB_USER/spring-cloud-dataflow-processor-server:$SERVER_RELEASE
rm dataflow-ms-flow-centric-process-poc.jar