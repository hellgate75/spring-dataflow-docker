#!/bin/sh

PWD="$(pwd)"
FOLDER="$PWD"

DATAFLOW_CENTRIC_PROJECT_CONTAINING_FOLDER=".."

. $FOLDER/docker-vars.sh
. $FOLDER/push-config.sh
if [ -e $FOLDER/push-dev-config.sh ]; then
	. $FOLDER/push-dev-config.sh
fi

DOCKERHUB_USER=""
DOCKERHUB_TOKEN=""

UNAME="$(uname -a 2> /dev/null)"
TRAVIS_CI="no"
PRE_PWD="$(pwd)"
if [ "" != "$(echo $UNAME|grep Linux)" ]; then
	## Into Travis-CI build
	sudo sh -c "apt update && apt install -y openssh-server maven"
	sudo sh -c "cd $PWD/spring-cloud-config-server && unzip ssh.zip -d /root"
	sudo sh -c "chmod 600 /root/.ssh/*"
	cd ..
	git config --global user.name "hellgate75"
	git config --global user.email "hellgate75@gmail.com"
	git clone --depth=50 --branch=master https://github.com/hellgate75/dataflow-flow-centric-poc.git
    cd 	dataflow-flow-centric-poc
else
	cd $DATAFLOW_CENTRIC_PROJECT_CONTAINING_FOLDER/dataflow-flow-centric-poc
	
fi 
mvn clean install
if [ ! -e ./spring-dataflow-docker ]; then
	echo "Linking to $PRE_PWD"
	ln -s spring-dataflow-docker $PRE_PWD
	echo "List of $PWD folder:"
	ls -latr
fi
cd spring-dataflow-docker
PWD="$(pwd)"
FOLDER="$PWD"
echo "current folder: $PWD"
TRAVIS_CI="yes"


###############################################################################
#### C H E C K   D O C K E R - H U B   V A R I A B L E S   P R E S E N C E ####
###############################################################################

if [ "" != "$(which docker-hub-variables)" ]; then
	## Sample docker-hub-variables file
	## #!/bin/sh -e
	## DOCKERHUB_USER="xxxxxxxxxxxx"
	## DOCKERHUB_TOKEN="xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx"
	source "$(which docker-hub-variables)"
fi

###############################################################################
#### C H E C K   D O C K E R - H U B   A C C E S S   I N F O R M A T I O N ####
###############################################################################

if [ "" != "$DOCKERHUB_USER" ]; then
   if [ "" != "$DOCKERHUB_TOKEN" ]; then
		echo "Logging to Docker Hub, with given token / password"
		docker login -u $DOCKERHUB_USER -p $DOCKERHUB_TOKEN 2> /dev/null
   else
	   	echo "Logging to Docker Hub, please type or paste your token / password:"
		docker login -u $DOCKERHUB_USER --password-stdin
   fi
else
	if [ "" != "$(which connect-docker-hub)" ]; then
		## Sample connect-docker-hub file
		## #!/bin/sh
		## DOCKERHUB_USER="xxxxxxxxxxxx"
		## DOCKERHUB_TOKEN="xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx"
		## if [ "" != "$DOCKERHUB_USER" ]; then
   		## if [ "" != "$DOCKERHUB_TOKEN" ]; then
		##                 echo "Logging to Docker Hub, with given token / password"
		##                 docker login -u $DOCKERHUB_USER -p $DOCKERHUB_TOKEN 2> /dev/null
		##    else
		##                 echo "Logging to Docker Hub, please type or paste your token / password:"
		##                 docker login -u $DOCKERHUB_USER --password-stdin
		##    fi
		## fi
		connect-docker-hub
	fi
	
fi

DOCKER_IMAGE_USER="hellgate75"

##########################
#### R A B B I T  M Q ####
##########################

if [ "" = "$(docker image ls | grep rabbitmq | grep $RABBITMQ_RELEASE)" ]; then
   echo "Pulling RabbitMQ v. $RABBITMQ_RELEASE docker image"
   docker pull rabbitmq:$RABBITMQ_RELEASE
else
	echo "RabbitMQ v. $RABBITMQ_RELEASE docker image push not required!!"
fi
# run sample of Rabbit MQ custom container:
# docker run -d --tty --rm -p 4369:4369 -p 5671:5671 -p 25672:25672 -p 9082:15672 -p 9672:5672 --name test-rabbitmq-2 rabbitmq:3.8-rc-management


RABBITMQ_FOLDER="$FOLDER/system-services-rabbitmq"
RES="0"
echo "Creating Custom RabbitMQ v. $RABBITMQ_RELEASE-flow-centric docker image"
cd $RABBITMQ_FOLDER
sh ./create-custom-rabbitmq-docker-image.sh
RES="$?"
echo "Results: $RES"
if [ "true" = "$PUSH_RABBITMQ" ]; then
  if [ "0" != "$RES" ] && [ "" != "$DOCKER_IMAGE_USER" ] && [ "no" = "$TRAVIS_CI" ]; then
     docker push $DOCKER_IMAGE_USER/rabbitmq:$CUSTOM_RABBITMQ_RELEASE
  fi
else
	echo "Custom RabbitMQ v. $RABBITMQ_RELEASE-flow-centric docker image push not required!!"
fi
if [ "0" != "$RES" ]; then
	exit $RES
fi
# run sample of Custom Rabbit MQ custom container:
# docker run -d --tty --rm -p 4369:4369 -p 5671:5671 -p 25672:25672 -p 9082:15672 -p 9672:5672 --name test-rabbitmq-2 rabbitmq:3.8-rc-management-flow-centric
cd "$PWD"





#MONGO_FOLDER="$FOLDER/system-services-mongodb"
#if [ "" = "$(docker image ls | grep mongo | grep $MONGO_RELEASE)" ]; then
#   echo "Pulling MongoDb v. $MONGO_RELEASE docker image"
#   docker pull mongo:$MONGO_RELEASE
#else
#	echo "MongoDb v. $MONGO_RELEASE docker image push not required!!"
#fi
# run sample of Oracle JDK custom container:
# docker run -d --tty --rm -p 27017:27017 --name test-mongo-2 mongo:3.6.17-xenial
# Connection docker machine
# docker run -d --tty --rm --name test-connect-mongo-2 mongo:3.6.17-xenial\
#    mongo --host $(sh ./docker-machine-ip.sh):27017


#############################
#### C U S T O M   J D K ####
#############################
RES="0"
JDK_FOLDER="$FOLDER/system-infra-oracle-jdk-1.8"
echo "Creating Oracle JDK v. $JDK_VERSION Ubuntu docker image"
cd "$JDK_FOLDER"
if [ ! -e $JDK_FOLDER/jdk-8u241-linux-x64.tar.gz ]; then
curl -L https://ftorelli-software-compliance-repository.s3-eu-west-1.amazonaws.com/flow-centric/PoC/jdk-8u241-linux-x64.tar.gz -o $JDK_FOLDER/jdk-8u241-linux-x64.tar.gz
fi
docker --debug image build --rm . -t $DOCKER_IMAGE_USER/oracle-jdk8:$JDK_VERSION
RES="$?"
echo "Results: $RES"
if [ "true" = "$PUSH_JDK" ]; then
  if [ "0" = "$RES" ] && [ "" != "$DOCKER_IMAGE_USER" ] && [ "no" = "$TRAVIS_CI" ]; then
     docker push $DOCKER_IMAGE_USER/oracle-jdk8:$JDK_VERSION
  fi
else
	echo "Oracle JDK v. $JDK_VERSION Ubuntu docker image push not required!!"
fi
if [ "0" != "$RES" ]; then
	exit $RES
fi
# run sample of Oracle JDK custom container:
# docker run --interactive --tty --rm --name test-jdk-2 hellgate75/oracle-jdk8:1.8.241-x64
cd "$PWD"


#########################################################
#### C U S T O M   H 2  D A T A B A S E  S E R V E R ####
#########################################################

H2D_FOLDER="$FOLDER/system-services-h2-database-server"
RES="0"
echo "Creating H2 Database v. $H2_DATABASE_RELEASE docker image"
cd "$H2D_FOLDER"
docker --debug image build --rm . -t $DOCKER_IMAGE_USER/h2-database:$H2_DATABASE_RELEASE
RES="$?"
echo "Results: $RES"
if [ "true" = "$PUSH_H2D" ]; then
  if [ "0" = "$RES" ] && [ "" != "$DOCKER_IMAGE_USER" ] && [ "no" = "$TRAVIS_CI" ]; then
     docker push $DOCKER_IMAGE_USER/h2-database:$H2_DATABASE_RELEASE
  fi
else
	echo "H2 Database v. $H2_DATABASE_RELEASE docker image push not required!!"
fi
# run sample of H2 custom container:
# docker run  -d --tty --rm -v h2_data_volume:/var/h2-database/data -p 9081:9090 -p 65123:65123 -e "H2_ENABLE_WEB=true" -e "H2_ENABLE_INSECURE=true" -e "H2_ENABLE_SECURE=false" -e "H2_DATA_GIT_URL=git@github.com:hellgate75/dataflow-flow-centric-config.git|/data" --name test-h2-2 hellgate75/h2-database:2019.10.14
# docker run -interactive --tty --rm -v h2_data_volume:/var/h2-database/data -p 9099:9090 -p 65124:65123 -e "H2_ENABLE_WEB=true" -e "H2_ENABLE_INSECURE=true" -e "H2_ENABLE_SECURE=false" -e "H2_DATA_GIT_URL=git@github.com:hellgate75/dataflow-flow-centric-config.git|/data" --name test-h2-3 hellgate75/h2-database:2019.10.14
if [ "0" != "$RES" ]; then
	exit $RES
fi
cd "$PWD"



###########################################################################
#### C U S T O M   S P R I N G   C L O U D   C O N F I G   S E R V E R ####
###########################################################################

CONFIG_SERVER_FOLDER="$FOLDER/spring-cloud-config-server"
RES="0"
echo "Creating Spring Cloud Config Server for Flow Centric v. $CONFIG_SERVER_RELEASE docker image"
cd $CONFIG_SERVER_FOLDER
./create-config-server-docker-image.sh
RES="$?"
echo "Results: $RES"
if [ "true" = "$PUSH_CONFIG_SERVER" ]; then
  cd $PWD
  if [ "0" = "$RES" ] && [ "" != "$DOCKER_IMAGE_USER" ] && [ "no" = "$TRAVIS_CI" ]; then
     docker push $DOCKER_IMAGE_USER/spring-cloud-config-server:$CONFIG_SERVER_RELEASE
  fi
else
	echo "Spring Cloud Config Server for Flow Centric v. $CONFIG_SERVER_RELEASE docker image push not required!!"
fi
## run sample of Config Server custom container:
## docker run -d --tty --rm -p 8888:8888 --name test-config-server-2 hellgate75/spring-cloud-config-server:1.0.0-flow-centric
if [ "0" != "$RES" ]; then
	exit $RES
fi
cd "$PWD"


###################################################################################################
#### C U S T O M   S P R I N G   C L O U D   D A T A F L O W   -   S O U R C E   S E R V I C E ####
###################################################################################################

DATAFLOW_SOURCE_SERVER_FOLDER="$FOLDER/spring-dataflow-ms-source"
RES="0"
echo "Creating Spring Cloud Dataflow Source Server for Flow Centric v. $SOURCE_SERVER_RELEASE docker image"
cd $DATAFLOW_SOURCE_SERVER_FOLDER
./create-dataflow-source-server-docker-image.sh
RES="$?"
echo "Results: $RES"
if [ "true" = "$PUSH_DATAFLOW_SOURCE_SERVER" ]; then
  cd $PWD
  if [ "0" = "$RES" ] && [ "" != "$DOCKER_IMAGE_USER" ] && [ "no" = "$TRAVIS_CI" ]; then
     docker push $DOCKER_IMAGE_USER/spring-cloud-dataflow-source-server:$SOURCE_SERVER_RELEASE
  fi
else
	echo "Spring Cloud Dataflow Source Server for Flow Centric v. $SOURCE_SERVER_RELEASE docker image push not required!!"
fi
## run sample of Dataflow Source Server custom container:
## docker run -d --tty --rm -p 8996:8996 --name test-dataflow-source-server-2 hellgate75/spring-cloud-dataflow-source-server:1.0.0-flow-centric
if [ "0" != "$RES" ]; then
	exit $RES
fi
cd "$PWD"

########################################################################################################
#### C U S T O M   S P R I N G   C L O U D   D A T A F L O W   -   P R O C E S S O R  S E R V I C E ####
########################################################################################################

DATAFLOW_PROCESS_SERVER_FOLDER="$FOLDER/processor-server"
RES="0"
echo "Creating Spring Cloud Dataflow Processor Server for Flow Centric v. $PROCESS_SERVER_RELEASE docker image"
cd $DATAFLOW_PROCESS_SERVER_FOLDER
./create-dataflow-processor-server-docker-image.sh
RES="$?"
echo "Results: $RES"
if [ "true" = "$PUSH_DATAFLOW_PROCESS_SERVER" ]; then
  cd $PWD
  if [ "0" = "$RES" ] && [ "" != "$DOCKER_IMAGE_USER" ] && [ "no" = "$TRAVIS_CI" ]; then
     docker push $DOCKER_IMAGE_USER/spring-cloud-dataflow-processor-server:$PROCESS_SERVER_RELEASE
  else
  fi
else
	echo "Spring Cloud Dataflow Processor Server for Flow Centric v. $PROCESS_SERVER_RELEASE docker image push not required!!"
fi
## run sample of Dataflow Source Server custom container:
## docker run -d --tty --rm -p 8997:8997 --name test-dataflow-processor-server-2 hellgate75/spring-cloud-dataflow-processor-server:1.0.0-flow-centric
if [ "0" != "$RES" ]; then
	exit $RES
fi
cd "$PWD"


###############################################################################################
#### C U S T O M   S P R I N G   C L O U D   D A T A F L O W   -   S I N K   S E R V I C E ####
###############################################################################################

DATAFLOW_SINK_SERVER_FOLDER="$FOLDER/sink-server"
RES="0"
echo "Creating Spring Cloud Dataflow Sink Server for Flow Centric v. $SOURCE_SERVER_RELEASE docker image"
cd $DATAFLOW_SINK_SERVER_FOLDER
./create-dataflow-sink-server-docker-image.sh
RES="$?"
echo "Results: $RES"
if [ "true" = "$PUSH_DATAFLOW_SINK_SERVER" ]; then
  cd $PWD
  if [ "0" = "$RES" ] && [ "" != "$DOCKER_IMAGE_USER" ] && [ "no" = "$TRAVIS_CI" ]; then
     docker push $DOCKER_IMAGE_USER/spring-cloud-dataflow-sink-server:$SINK_SERVER_RELEASE
  fi
else
	echo "Spring Cloud Dataflow Sink Server for Flow Centric v. $SINK_SERVER_RELEASE docker image push not required!!"
fi
## run sample of Dataflow Source Server custom container:
## docker run -d --tty --rm -p 8998:8998 --name test-dataflow-sink-server-2 hellgate75/spring-cloud-dataflow-sink-server:1.0.0-flow-centric
if [ "0" != "$RES" ]; then
	exit $RES
fi
cd "$PWD"


if [ "" != "$DOCKERHUB_USER" ]; then
   docker logout
else
	if [ "" != "$(which disconnect-docker-hub)" ]; then
		## Sample docker-hub-variables file
		## #!/bin/sh
		## docker logout
		disconnect-docker-hub
	fi
fi
if [ -e ./spring-dataflow-docker ]; then
    cd ..
	rm -f spring-dataflow-docker
fi

exit 0