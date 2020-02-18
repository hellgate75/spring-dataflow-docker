#!/bin/sh

echo "Starting pull procedure ..."

PWD="$(pwd)"
FOLDER="$(dirname "$(realpath "$0")")"

source "$FOLDER/docker-vars.sh"

DOCKERHUB_USER="hellgate75"

##########################
#### R A B B I T  M Q ####
##########################

echo "Pulling RabbitMQ v. $RABBITMQ_RELEASE docker image"
docker pull rabbitmq:$RABBITMQ_RELEASE
echo "Pulling RabbitMQ customization v. $CUSTOM_RABBITMQ_RELEASE docker image"
docker pull $DOCKERHUB_USER/rabbitmq:$CUSTOM_RABBITMQ_RELEASE


#########################
#### M O N G O   D B ####
#########################
echo "Pulling MongoDb v. $MONGO_RELEASE docker image"
docker pull mongo:$MONGO_RELEASE


#############################
#### C U S T O M   J D K ####
#############################
echo "Pulling Custom Oracle JDK v. $JDK_VERSION Ubuntu docker image"
docker pull $DOCKERHUB_USER/oracle-jdk8:$JDK_VERSION


#########################################################
#### C U S T O M   H 2  D A T A B A S E  S E R V E R ####
#########################################################
echo "Pulling H2 Database v. $H2_DATABASE_RELEASE docker image"
docker pull $DOCKERHUB_USER/h2-database:$H2_DATABASE_RELEASE



###########################################################################
#### C U S T O M   S P R I N G   C L O U D   C O N F I G   S E R V E R ####
###########################################################################
echo "Pulling Spring Cloud Config Server for Flow Centric v. $CONFIG_SERVER_RELEASE docker image"
docker pull $DOCKERHUB_USER/spring-cloud-config-server:$CONFIG_SERVER_RELEASE



###################################################################################################
#### C U S T O M   S P R I N G   C L O U D   D A T A F L O W   -   S O U R C E   S E R V I C E ####
###################################################################################################
echo "Pulling Spring Cloud Dataflow Source Server for Flow Centric v. $SOURCE_SERVER_RELEASE docker image"
docker pull $DOCKERHUB_USER/spring-cloud-dataflow-source-server:$SOURCE_SERVER_RELEASE


########################################################################################################
#### C U S T O M   S P R I N G   C L O U D   D A T A F L O W   -   P R O C E S S O R  S E R V I C E ####
########################################################################################################
echo "Pulling Spring Cloud Dataflow Processor Server for Flow Centric v. $PROCESS_SERVER_RELEASE docker image"
docker pull $DOCKERHUB_USER/spring-cloud-dataflow-processor-server:$PROCESS_SERVER_RELEASE



###############################################################################################
#### C U S T O M   S P R I N G   C L O U D   D A T A F L O W   -   S I N K   S E R V I C E ####
###############################################################################################
echo "Pulling Spring Cloud Dataflow Sink Server for Flow Centric v. $SOURCE_SERVER_RELEASE docker image"
docker pull $DOCKERHUB_USER/spring-cloud-dataflow-sink-server:$SINK_SERVER_RELEASE

echo "Pulling procedure complete!!"
