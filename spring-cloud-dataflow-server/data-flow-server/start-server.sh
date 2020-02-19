#!/bin/bash
FOLDER="$(realpath "$(dirname "$0")")"
source $FOLDER/ms-env.sh
ARGS="$APP_ARGS"
mkdir -p /opt/$APP_GROUP/log
mkdir -p /opt/$APP_GROUP/log/$APP_NAME/
echo "Starting $APP_DESCR v. $(cat /opt/$APP_GROUP/$APP_NAME/jar/version) ..."
echo "JVM ARGS: $JVM_ARGS"
echo "APP ARGS: $ARGS"
echo ""
if [ "yes" != "$DEBUG_ALL_SERVERS" ]; then
	DEBUG_SPRING=""
fi
CMD="java $JVM_ARGS -jar /opt/$APP_GROUP/$APP_NAME/jar/$APP_NAME.jar $MAIN_CLASS $ARGS $DEBUG_SPRING"
if [ "yes" = "$SKIP_LOGGING" ]; then
	nohup execute.sh "$CMD"
else
	BOOTSTRAP_LOG_FILE="/opt/$APP_GROUP/log/$APP_NAME/$APP_NAME-$LOG_LEVEL.log"
	nohup execute.sh "$CMD" > $BOOTSTRAP_LOG_FILE 2>&1 &
fi

if [ "yes" != "$SKIP_LOGGING" ]; then
	echo ""
	echo "$APP_DESCR v. $(cat /opt/$APP_GROUP/$APP_NAME/jar/version) $LOG_LEVEL logs"
	echo "====================================================================="
	echo "Log file: $BOOTSTRAP_LOG_FILE"
	echo ""
	COUNTER=0
	while [ ! -e $BOOTSTRAP_LOG_FILE ] && [ $COUNTER -le 200  ] ; do 
	   sleep 5
	   COUNTER=$((COUNTER + 1))
	   printf "."
	done
	if [ ! -e $BOOTSTRAP_LOG_FILE ] && [ "true" != "$SHUTDOWN_ON_JVM_EXIT" ]; then
		echo "Log file $BOOTSTRAP_LOG_FILE doesn't exists. Taking up the container to check the problem"
		echo "type :"
		echo "     docker exec -i -t <container_name> bash"
		echo "and use the shell to understand what happened!!"
		sleep infinity
	elif [ -e $BOOTSTRAP_LOG_FILE ]; then
		tail -f $BOOTSTRAP_LOG_FILE
	else
		echo "Exit the container!!"
	fi
fi
