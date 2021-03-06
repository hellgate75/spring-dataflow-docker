FROM hellgate75/oracle-jdk8:1.8.241-x64
LABEL MAINTAINER Fabrizio Torelli <hellgate75@gmail.com> <https://www.linkedin.com/in/fabriziotorelli)

# Spring Cloud Dataflow Server Environment Variables
# Spring Cloud Config Server
ENV CONFIG_SERVER_HOSTNAME=configserver\
 CONFIG_SERVER_PORT=8888\
 CONFIG_DF_APP_NAME=spring-cloud-dataflow-server\
 CONFIG_SK_APP_NAME=spring-cloud-skipper-server\
 CONFIG_DF_PROFILE=local\
 CONFIG_SK_PROFILE=local
# Spring Cloud Dataflow Server
ENV SHUTDOWN_ON_JVM_EXIT=false\
 DEBUG_ALL_SERVERS=false\
 DF_DEBUG_LEVEL=INFO\
 DF_MIN_HEAP_SIZE=512m\
 DF_MAX_HEAP_SIZE=1536m\
 DF_JVM_EXTRA_ARGS="-XX:+UseConcMarkSweepGC -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Djava.security.egd=file:/dev/./urandom"\
 SK_DEBUG_LEVEL=INFO\
 SK_MIN_HEAP_SIZE=512m\
 SK_MAX_HEAP_SIZE=1024m\
 SK_JVM_EXTRA_ARGS="-XX:+UseConcMarkSweepGC -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -Djava.security.egd=file:/dev/./urandom"

#Create folders
RUN mkdir -p /opt/spring-cloud-space/spring-cloud-dataflow-server/bin \
  /opt/spring-cloud-space/spring-cloud-dataflow-server/jar \
  /opt/spring-cloud-space/spring-cloud-dataflow-shell/bin \
  /opt/spring-cloud-space/spring-cloud-dataflow-shell/jar \
  /opt/spring-cloud-space/spring-cloud-skipper-server/bin \
  /opt/spring-cloud-space/spring-cloud-skipper-server/jar \
  /opt/spring-cloud-space/spring-cloud-skipper-shell/bin \
  /opt/spring-cloud-space/spring-cloud-skipper-shell/jar \
  /opt/spring-cloud-space/bin \
  /opt/spring-cloud-space/temp \
  /opt/spring-cloud-space/config \
  /opt/spring-cloud-space/logs/spring-cloud-dataflow-server \
  /opt/spring-cloud-space/logs/spring-cloud-skipper-server

COPY ./download-jars.sh /opt/spring-cloud-space/temp
COPY ./install-jars.sh /opt/spring-cloud-space/temp
COPY ./env.sh /opt/spring-cloud-space/temp

RUN \
 chmod 777 /opt/spring-cloud-space/temp/download-jars.sh \ 
 /opt/spring-cloud-space/temp/install-jars.sh \ 
 /opt/spring-cloud-space/temp/env.sh &&\ 
 sh /opt/spring-cloud-space/temp/download-jars.sh &&\
 sh /opt/spring-cloud-space/temp/install-jars.sh &&\
 rm -Rf /opt/spring-cloud-space/temp


# Copy required scripts - dataflow server
COPY ./data-flow-server/start-server.sh /opt/spring-cloud-space/spring-cloud-dataflow-server/bin
COPY ./data-flow-server/execute.sh /opt/spring-cloud-space/spring-cloud-dataflow-server/bin
COPY ./data-flow-server/ms-env.sh /opt/spring-cloud-space/spring-cloud-dataflow-server/bin

# Copy required scripts - dataflow shell
COPY ./data-flow-shell/start-shell.sh /opt/spring-cloud-space/spring-cloud-dataflow-shell/bin
COPY ./data-flow-shell/ms-env.sh /opt/spring-cloud-space/spring-cloud-dataflow-shell/bin

# Copy required scripts - skipper server
COPY ./data-flow-server/start-server.sh /opt/spring-cloud-space/spring-cloud-skipper-server/bin
COPY ./data-flow-server/execute.sh /opt/spring-cloud-space/spring-cloud-skipper-server/bin
COPY ./skipper-server/ms-env.sh /opt/spring-cloud-space/spring-cloud-skipper-server/bin

# Copy required scripts - skipper shell
COPY ./data-flow-shell/start-shell.sh /opt/spring-cloud-space/spring-cloud-skipper-shell/bin
COPY ./skipper-shell/ms-env.sh /opt/spring-cloud-space/spring-cloud-skipper-shell/bin

# Copy main required scripts - executables in main path
COPY ./kill-all /opt/spring-cloud-space/bin
COPY ./shutdown /opt/spring-cloud-space/bin
COPY ./check-state-by-port.sh /opt/spring-cloud-space/bin
COPY ./start-dataflow-server.sh /opt/spring-cloud-space/bin
COPY ./start-skipper-server.sh /opt/spring-cloud-space/bin
COPY ./shell /opt/spring-cloud-space/bin
COPY ./start-all-servers.sh /opt/spring-cloud-space/bin
COPY ./skipper-env.sh /opt/spring-cloud-space/bin


# Change shell script files permissions
RUN chmod 777 /opt/spring-cloud-space/spring-cloud-dataflow-server/bin/ms-env.sh \
  /opt/spring-cloud-space/spring-cloud-dataflow-server/bin/start-server.sh \
  /opt/spring-cloud-space/spring-cloud-dataflow-server/bin/execute.sh \
  /opt/spring-cloud-space/spring-cloud-dataflow-shell/bin/ms-env.sh \
  /opt/spring-cloud-space/spring-cloud-dataflow-shell/bin/start-shell.sh \
  /opt/spring-cloud-space/spring-cloud-skipper-server/bin/ms-env.sh \
  /opt/spring-cloud-space/spring-cloud-skipper-server/bin/start-server.sh \
  /opt/spring-cloud-space/spring-cloud-skipper-server/bin/execute.sh \
  /opt/spring-cloud-space/spring-cloud-skipper-shell/bin/ms-env.sh \
  /opt/spring-cloud-space/spring-cloud-skipper-shell/bin/start-shell.sh \
  /opt/spring-cloud-space/bin/shutdown \
  /opt/spring-cloud-space/bin/kill-all \
  /opt/spring-cloud-space/bin/check-state-by-port.sh \
  /opt/spring-cloud-space/bin/start-dataflow-server.sh \
  /opt/spring-cloud-space/bin/start-skipper-server.sh \
  /opt/spring-cloud-space/bin/shell \
  /opt/spring-cloud-space/bin/start-all-servers.sh \
  /opt/spring-cloud-space/bin/skipper-env.sh

ENV HOME=/opt/spring-cloud-space
ENV PATH=${PATH}:/opt/spring-cloud-space/bin
# Change of Working Directory
WORKDIR /opt/spring-cloud-space

# Docker Image parameters ...
VOLUME /opt/spring-cloud-space/log

VOLUME /opt/spring-cloud-space/config

EXPOSE 9393 7577

ENTRYPOINT ["/bin/bash"]

CMD ["start-all-servers.sh"]