#!/bin/sh -e
export OUTFOLDER="/opt/spring-cloud-space/temp/jars"
export SCDF_RELEASE="2.3.0.RELEASE"
export SKIPPER_RELEASE="2.3.0.RELEASE"
export DFS_FOLDER="/opt/spring-cloud-space/spring-cloud-dataflow-server/jar"
export DFH_FOLDER="/opt/spring-cloud-space/spring-cloud-dataflow-shell/jar"
export SKS_FOLDER="/opt/spring-cloud-space/spring-cloud-skipper-server/jar"
export SKH_FOLDER="/opt/spring-cloud-space/spring-cloud-skipper-shell/jar"
if [ "" != "$SPRING_CLOUD_DATAFLOW_VERSION" ]; then
	SCDF_RELEASE="$SPRING_CLOUD_DATAFLOW_VERSION"
fi
if [ "" != "$SPRING_CLOUD_SKIPPER_VERSION" ]; then
	SKIPPER_RELEASE="$SPRING_CLOUD_SKIPPER_VERSION"
fi

