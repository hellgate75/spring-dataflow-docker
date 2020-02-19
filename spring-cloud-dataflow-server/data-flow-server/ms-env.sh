#!/bin/bash -e
source $(which skipper-env.sh)
export APP_DESCR="Spring Cloud Dataflow Server"
export APP_NAME="spring-cloud-dataflow-server"
export LOG_LEVEL="service"
export SKIP_LOGGING="false"
export DEBUG_SPRING="--debug=true"
export APP_ARGS="--spring.cloud.skipper.client.serverUri=$SKIPPER_PROTOCOL://$SKIPPER_HOST:$SKIPPER_PORT/api --logging.level.org.springframework.cloud=$DF_DEBUG_LEVEL --spring.application.name=$CONFIG_DF_APP_NAME --spring.profiles.active=$CONFIG_DF_PROFILE"
export JVM_ARGS="-Xms$DF_MIN_HEAP_SIZE -Xmx$DF_MAX_HEAP_SIZE $DF_JVM_EXTRA_ARGS"
export APP_GROUP="spring-cloud-space"
