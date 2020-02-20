#!/bin/sh -e
if [ "" = "$RABBITMQ_RELEASE" ]; then
	RABBITMQ_RELEASE=3.8-rc-management
fi
if [ "" = "$DOCKER_IMAGE_USER" ]; then
	DOCKER_IMAGE_USER=hellgate75
fi
docker --debug image build --rm . -t $DOCKER_IMAGE_USER/rabbitmq:$RABBITMQ_RELEASE-flow-centric
