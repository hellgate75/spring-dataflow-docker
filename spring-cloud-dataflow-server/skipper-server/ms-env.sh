#!/bin/bash -e
export APP_DESCR="Spring Cloud Skipper Server"
export APP_NAME="spring-cloud-skipper-server"
export LOG_LEVEL="service"
export SKIP_LOGGING="true"
export DEBUG_SPRING="--debug=true"
export APP_ARGS="--logging.level.org.springframework.cloud=$SK_DEBUG_LEVEL --spring.application.name=$CONFIG_SK_APP_NAME --spring.profiles.active=$CONFIG_SK_PROFILE"
export JVM_ARGS="-Xms$SK_MIN_HEAP_SIZE -Xmx$SK_MAX_HEAP_SIZE $SK_JVM_EXTRA_ARGS"
export APP_GROUP="spring-cloud-space"
