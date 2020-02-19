#!/bin/sh
FOLDER="$(realpath "$(dirname "$0")")"
if [ "" = "$SERVER_RELEASE" ]; then
	SERVER_RELEASE="1.0.0"
fi
if [ "" = "$DOCKERHUB_USER" ]; then
	DOCKERHUB_USER=hellgate75
fi
VARRGS=""
for argument in $(cat $FOLDER/spring-cloud-dataflow-vars.env); do
  VARRGS="$VARRGS --build-arg $argument"
done
echo "Using arguments:$VARRGS"
docker --debug image build $VARRGS --rm . -t $DOCKERHUB_USER/spring-cloud-dataflow-server:$SERVER_RELEASE
