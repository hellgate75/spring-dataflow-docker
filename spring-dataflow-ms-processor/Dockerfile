FROM hellgate75/oracle-jdk8:1.8.241-x64
LABEL MAINTAINER Fabrizio Torelli <hellgate75@gmail.com> <https://www.linkedin.com/in/fabriziotorelli)

# H2 Database Environment Variables
ENV CONFIG_SERVER_HOSTNAME	configserver.flowcentric
ENV CONFIG_SERVER_PORT		8888
ENV SHUTDOWN_ON_JVM_EXIT	false

#Create folders
RUN mkdir -p /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
RUN mkdir -p /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/jar

# Copy required scripts
COPY ./start-server.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
COPY ./stop-server.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
COPY ./execute.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
COPY ./kill-all.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
COPY ./ms-env.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
COPY ./shutdown /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
COPY ./dataflow-ms-flow-centric-process-poc.jar /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/jar

# Change shell script permissions
RUN chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin/ms-env.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin/start-server.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin/stop-server.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin/execute.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin/shutdown &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin/kill-all.sh &&\
 chmod 660 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/jar/dataflow-ms-flow-centric-process-poc.jar
ENV HOME=/opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc
ENV PATH=${PATH}:/opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc/bin
# Change of Working Directory
WORKDIR /opt/dataflow-flow-centric/dataflow-ms-flow-centric-process-poc

# Docker Image parameters ...
VOLUME /opt/dataflow-flow-centric/log

EXPOSE 8997

ENTRYPOINT ["/bin/bash"]

CMD ["start-server.sh"]