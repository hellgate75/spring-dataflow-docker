#!/bin/bash
FOLDER="$(dirname "$(which start-server.sh)")"
CONFIG_FILE="$(which ms-env.sh)"
echo "CONFIG_FILE=$CONFIG_FILE"
source $CONFIG_FILE
ARGS="$APP_ARGS"
LOG_FOLDER="/opt/spring-cloud-group/log/$APP_GROUP_FOLDER/$APP_NAME"
mkdir -p $LOG_FOLDER
mkdir -p LOG_FOLDER
echo "Starting $APP_DESCR ..."
echo "JVM ARGS: $JVM_ARGS"
echo "APP ARGS: $ARGS"
echo ""
if [ -e $CONFIG_FILE_PATH ]; then
	echo "Using config file at path: $CONFIG_FILE_PATH"
	chmod 666 $CONFIG_FILE_PATH
else
	echo "Unable to find config file at path: $CONFIG_FILE_PATH"
	if [ "true" != "$SHUTDOWN_ON_JVM_EXIT" ]; then
		echo "Waiting for an action by the sysadmis..."
		sleep infinity
	fi
	echo "Exit script"
	exit 1
fi
CMD="java $JVM_ARGS -jar /opt/spring-cloud-group/dataflow-ms-config-server/jar/$APP_NAME.jar $MAIN_CLASS $ARGS"
BOOTSTRAP_LOG_FILE="$LOG_FOLDER/$APP_NAME.log"
if [ "yes" = "$REDIRECT_OUTPUT_TO_APP" ]; then
	BOOTSTRAP_LOG_FILE="$LOG_FOLDER/$APP_NAME-$LOG_LEVEL.log"
	nohup execute.sh "$CMD" > $BOOTSTRAP_LOG_FILE 2>&1 &
else
	nohup execute.sh "$CMD" > $BOOTSTRAP_LOG_FILE 2>&1 &
fi
PID1="$(ps -eaf| grep java|grep -v /bin/sh|grep -v grep|awk 'BEGIN {FS=OFS=" "}{print $2}')"
PID2="$(ps -eaf| grep java|grep /bin/sh|grep -v grep|awk 'BEGIN {FS=OFS=" "}{print $2}')"
PID3="$(ps -eaf| grep tail|grep -v grep|awk 'BEGIN {FS=OFS=" "}{print $2}')"
echo ""
if [ "" != "$PID1" ]; then
	mkdir -p /var/run/$APP_GROUP
	echo "$PID1 $PID2 $PID3" > /var/run/$APP_GROUP/$APP_NAME.pid
	echo "JVM Process Id: $PID1"
else
	echo "No Process Id. Application failed to start..."
fi
echo ""
echo "$APP_DESCR $LOG_LEVEL logs"
echo "====================================================================="
echo "Log file: $LOG_FOLDER/$APP_NAME-$LOG_LEVEL.log"
echo ""
COUNTER=0
while [ ! -e $LOG_FOLDER/$APP_NAME-$LOG_LEVEL.log ] && [ $COUNTER -le 200  ] ; do 
   sleep 5
   COUNTER=$((COUNTER + 1))
   printf "."
done
tail -f $LOG_FOLDER/$APP_NAME-$LOG_LEVEL.log
if [ ! -e $LOG_FOLDER/$APP_NAME-$LOG_LEVEL.log ]; then
	echo "Log file doesn;t exists. Taking up the container to check the problem"
	echo "type :"
	echo "     docker exec -i -t <container_name> bash"
	echo "and use the shell to understand what happened!!"
	sleep infinity
fi
