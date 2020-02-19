#!/bin/bash
FOLDER="$(realpath "$(dirname "$0")")"
source $FOLDER/ms-env.sh
echo "Starting $APP_DESCR v. $(cat /opt/$APP_GROUP/$APP_NAME/jar/version) ..."
echo ""
if [[ -e /c/cygwin64/bin ]]; then
	export PATH=$PATH:/c/cygwin64/bin
fi
CMD="java $JVM_ARGS -jar /opt/$APP_GROUP/$APP_NAME/jar/$APP_NAME.jar"
eval "$CMD"
