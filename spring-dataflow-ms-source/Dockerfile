FROM hellgate75/oracle-jdk8:1.8.241-x64
LABEL MAINTAINER Fabrizio Torelli <hellgate75@gmail.com> <https://www.linkedin.com/in/fabriziotorelli)

# H2 Database Environment Variables
ENV CONFIG_SERVER_HOSTNAME	configserver.flowcentric
ENV CONFIG_SERVER_PORT		8888
ENV SHUTDOWN_ON_JVM_EXIT	false

#Create folders
RUN mkdir -p /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
RUN mkdir -p /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/jar

# Copy required scripts
COPY ./start-server.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
COPY ./stop-server.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
COPY ./execute.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
COPY ./kill-all.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
COPY ./ms-env.sh /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
COPY ./shutdown /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
COPY ./dataflow-ms-flow-centric-source-poc.jar /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/jar

# Change shell script permissions
RUN chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin/ms-env.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin/start-server.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin/stop-server.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin/execute.sh &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin/shutdown &&\
 chmod 777 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin/kill-all.sh &&\
 chmod 660 /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/jar/dataflow-ms-flow-centric-source-poc.jar
ENV HOME=/opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc
ENV PATH=${PATH}:/opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc/bin
# Change of Working Directory
WORKDIR /opt/dataflow-flow-centric/dataflow-ms-flow-centric-source-poc

# Docker Image parameters ...
VOLUME /opt/dataflow-flow-centric/log

EXPOSE 8996

ENTRYPOINT ["/bin/bash"]

CMD ["start-server.sh"]