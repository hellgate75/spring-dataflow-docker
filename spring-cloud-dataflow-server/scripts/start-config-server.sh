#!/bin/sh
SCRIPT_NAME="start-config-server.sh"
source ./.scriptsh
JVM_MAX_HEAP_SIZE="2g"
APP_PKG_SUFFIX="config-server"
PREFIX="dataflow-ms-merge-layer-${APP_PKG_SUFFIX}"
JAR_FILE="$(ls ../dataflow-ms-merge-layer-${APP_PKG_SUFFIX}/target/$PREFIX-*.jar)"
JAVA_SPRING_DEBUG="-Ddebug=true"
if [[ "--debug" != "$1" ]]; then
  JAVA_SPRING_DEBUG=""
fi
EXTRA_PARAMS="$JAVA_SPRING_DEBUG"
if [[ -e "$JAR_FILE" ]]; then
echo Running MergeLayer product config server -> logs available at 'log/merge-layer-config-server.log'
java -cp "$JAR_FILE" -jar "$JAR_FILE" -Xmx$JVM_MAX_HEAP_SIZE -XX:+UseConcMarkSweepGC $EXTRA_PARAMS  com.dataflow.ms.merge.layer.service.config.server.ConfigServerApplication > log/merge-layer-config-server.log &
PID="$(echo $!)"
echo "Started Merge Layer Spring Cloud Config Server"
echo "Process Id: $PID"
echo "$PID" > $(pwd)/var/mergelayer-config-server.pid
else
	echo "Java Executable $JAR_FILE doesn't exist, please rebuild the entire maven project set"
	echo "In base folder user 'mvn install'"
fi
