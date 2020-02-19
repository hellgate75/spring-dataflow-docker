#!/bin/sh

echo "Starting Spring Cloud Dataflow Infrastructure ..."

source $(which skipper-env.sh)
start-skipper-server.sh
COUNTER=0
OUTCOME=""
printf "Waiting for Spring Cloud Skipper Server to become active ..."
while [ "" = $OUTCOME ] && [ $COUNTER -le 20  ] ; do 
   sleep 20
   COUNTER=$((COUNTER + 1))
   printf "."
   OUTCOME="$(curl -vs $SKIPPER_PROTOCOL://$SKIPPER_HOST:$SKIPPER_PORT/api 2> /dev/null)"
done


if [ "" = "$OUTCOME" ]; then
	echo "Spring Cloud Skipper Server seems not started!!"
	if  [ "true" != "$SHUTDOWN_ON_JVM_EXIT" ]; then
		echo "Taking up the container to check the problem, please type:"
		echo "     docker exec -i -t <container_name> bash"
		echo "and use the shell to understand what happened!!"
	else
		echo "Exit the container!!"
	fi
else
	echo "*****************************************************************"
	echo "* After the start-up you can use following commands:            *"
	echo "* shell    - <dataflow|skipper> to start Skipper/Dataflow shell *"
	echo "* kill-all - To stop any process leaving running the container  *" 
	echo "* shutdown - To shutdown the container                          *"
	echo "*****************************************************************"
	echo ""
	echo ""
	sleep 5
	start-dataflow-server.sh
fi

echo "Spring Cloud Dataflow Infrastructure started!!"