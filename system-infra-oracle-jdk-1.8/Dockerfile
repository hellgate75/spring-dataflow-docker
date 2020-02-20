FROM ubuntu:eoan
LABEL MAINTAINER Fabrizio Torelli <hellgate75@gmail.com> <https://www.linkedin.com/in/fabriziotorelli)

# System Java 8 istallation Environment Variables
ENV JAVA_HOME       /usr/lib/jvm/jdk1.8.0_241
ENV PATH			${PATH}:${JAVA_HOME}/bin

RUN mkdir /root/jdk-install
RUN mkdir /usr/lib/jvm

# Copy required scripts
COPY ./jdk-8u241-linux-x64.tar.gz /root/jdk-install
COPY ./install-java.sh /root/jdk-install
COPY ./uninstall-java.sh /root

# Change shell script permissions
# Ubuntu updates and new packages installation
RUN chmod 777 /root/jdk-install/install-java.sh &&\
 chmod 777 /root/uninstall-java.sh &&\
 apt-get update && \
 apt-get install -y wget zip unzip vim iputils-* net-tools curl  && \
 apt-get clean all && \
 rm -rf /var/lib/apt/lists/* && \
 rm -rf /var/cache/oracle-jdk8-installer

# Change of Working Directory
WORKDIR /root/jdk-install

# Perform H2 Database installation by custom scripts
RUN ./install-java.sh -f ./jdk-8u241-linux-x64.tar.gz

# Change of Working Directory
WORKDIR /root

# Remove unused installation shell scripts
RUN rm -rf /root/jdk-install

# Test installation
RUN java -version

ENTRYPOINT ["/bin/bash"]
