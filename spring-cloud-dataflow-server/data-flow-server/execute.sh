#!/bin/bash
echo "Executing command: $@"
eval "$@"
if [ "true" = "$SHUTDOWN_ON_JVM_EXIT" ]; then
	shutdown -h now
fi