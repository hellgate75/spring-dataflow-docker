<p align="center">
<image width="120" height="90" src="images101-docker-logo.png"></image>&nbsp;
<image width="550" height="350" src="images/spring-dataflow-logo.png">
&nbsp;<image width="120" height="90" src="images/docker-logo.png"></image>
</p><br/>
<br/>
<p align="right">
<img src="https://travis-ci.org/hellgate75/spring-dataflow-docker.svg?branch=master" alt="trevis-ci" width="98" height="20" />
&nbsp;<a href="https://travis-ci.org/hellgate75/spring-dataflow-docker">Check last build on Travis-CI</a></p><br/>
<br/>




# Spring Dataflow Docker Images Repository

Spring Cloud Dataflow related docker container images





## Content

In this repository we have a proposal for Spring Cloud products dockerization. In the details we are containerizing Spring Cloud Dataflow Microservices.

Sample wants to give containers on request.

Here some provided sub-projects, by categoty.




### Spring Cloud

We prapared customized containers for following services:

* Spring Cloud Config Server available [here](/spring-cloud-config-server)

* Spring Cloud Dataflow Server available [here](/spring-dataflow-server)




### Useful service

We prapared customized containers for following services:

* JDK foundation docker image available [here](/system-infra-oracle-jdk-1.8)

* H2 Database server available [here](/system-services-h2-database-server)

* Rabbit MQ server available [here](/system-services-rabbitmq)




### Usage



We have two different files in the build foundation scripts:

* docker containers base versions available [here](/docker-vars.sh)

* Full build script available [here](/build-all.sh)


Enjoy the experience.



## License

The library is licensed with [LGPL v. 3.0](/LICENSE) clauses, with prior authorization of author before any production or commercial use. Use of this library or any extension is prohibited due to high risk of damages due to improper use. No warranty is provided for improper or unauthorized use of this library or any implementation.

Any request can be prompted to the author [Fabrizio Torelli](https://www.linkedin.com/in/fabriziotorelli) at the follwoing email address:

[hellgate75@gmail.com](mailto:hellgate75@gmail.com)
