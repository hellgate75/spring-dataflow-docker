FROM hellgate75/oracle-jdk8:1.8.241-x64
LABEL MAINTAINER Fabrizio Torelli <hellgate75@gmail.com> <https://www.linkedin.com/in/fabriziotorelli)

# H2 Database Environment Variables
#CONFIG_SERVER_CONFIG_FILE: enable read of custom file (false|true, default: false): file is present in shared volume as /var/spring-config-server/config/application.yaml
ENV USE_CUSTOM_CONFIG_FILE	false
ENV SHUTDOWN_ON_JVM_EXIT	false
#ENV CONFIG_SERVER_ENV: At the startup the condifg server will look forward condiguration at the following path:  /opt/spring-cloud-group/dataflow-ms-config-server/config/$APP_GROUP_FOLDER/$APP_ENV_FOLDER/application-$CONFIG_SERVER_ENV.$CONFIG_SERVER_FORMAT
ENV CONFIG_SERVER_ENV		dev
ENV CONFIG_SERVER_FORMAT	yml
ENV APP_GROUP_FOLDER		sample-cloud-project
ENV APP_ENV_FOLDER			dev
#ENV METHOD_PATH			/opt/spring-cloud-group/$APP_GROUP_FOLDER/config

#Create folders
RUN mkdir -p /opt/spring-cloud-group/dataflow-ms-config-server/bin &&\
 mkdir -p /opt/spring-cloud-group/dataflow-ms-config-server/jar &&\
 mkdir -p /opt/spring-cloud-group/dataflow-ms-config-server/config

RUN apt-get update && \
    apt-get install -y openssh-client openssh-known-hosts git && \
    apt-get clean all && \
	rm -rf /var/lib/apt/lists/*

# Copy required scripts
COPY ./start-server.sh /opt/spring-cloud-group/dataflow-ms-config-server/bin
COPY ./stop-server.sh /opt/spring-cloud-group/dataflow-ms-config-server/bin
COPY ./execute.sh /opt/spring-cloud-group/dataflow-ms-config-server/bin
COPY ./kill-all.sh /opt/spring-cloud-group/dataflow-ms-config-server/bin
COPY ./ms-env.sh /opt/spring-cloud-group/dataflow-ms-config-server/bin
COPY ./shutdown /opt/spring-cloud-group/dataflow-ms-config-server/bin

COPY ./dataflow-ms-config-server.jar /opt/spring-cloud-group/dataflow-ms-config-server/jar

COPY ./ssh.zip /root
RUN unzip /root/ssh.zip -d /root &&\
 chmod 600 /root/.ssh/id_rsa* &&\
 rm -f /root/ssh.zip

# Change shell script permissions
RUN chmod 777 /opt/spring-cloud-group/dataflow-ms-config-server/bin/ms-env.sh &&\
 chmod 777 /opt/spring-cloud-group/dataflow-ms-config-server/bin/start-server.sh &&\
 chmod 777 /opt/spring-cloud-group/dataflow-ms-config-server/bin/stop-server.sh &&\
 chmod 777 /opt/spring-cloud-group/dataflow-ms-config-server/bin/execute.sh &&\
 chmod 777 /opt/spring-cloud-group/dataflow-ms-config-server/bin/shutdown &&\
 chmod 777 /opt/spring-cloud-group/dataflow-ms-config-server/bin/kill-all.sh &&\
 chmod 660 /opt/spring-cloud-group/dataflow-ms-config-server/jar/dataflow-ms-config-server.jar
ENV HOME=/opt/spring-cloud-group/dataflow-ms-config-server
ENV PATH=${PATH}:/opt/spring-cloud-group/dataflow-ms-config-server/bin
# Change of Working Directory
WORKDIR /opt/spring-cloud-group/dataflow-ms-config-server

# Docker Image parameters ...
VOLUME /opt/spring-cloud-group/log

VOLUME /opt/spring-cloud-group/config

EXPOSE 8888

ENTRYPOINT ["/bin/bash"]

CMD ["start-server.sh"]