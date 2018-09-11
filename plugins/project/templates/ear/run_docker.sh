#!/bin/bash
set -e

./gradlew build

# Java EE 7 servers
docker run --rm --name appsvr -p 80:8080 -v $(pwd)/build/libs/template-artifactid.ear:/opt/jboss/wildfly/standalone/deployments/template-artifactid.ear jboss/wildfly:10.1.0.Final /opt/jboss/wildfly/bin/standalone.sh --server-config=standalone-full.xml -b "0.0.0.0"
#docker run --rm --name appsvr -p 80:9080 -p 443:9443 -v $(pwd)/build/libs/template-artifactid.ear:/config/dropins/template-artifactid.ear websphere-liberty:javaee7
#docker run --rm --name appsvr -p 9060:9060 -p 80:9080 -p 7777:7777 -v $(pwd)/build/libs/template-artifactid.ear:/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/monitoredDeployableApps/servers/server1/template-artifactid.ear 38leinad/was-9
#docker run --rm --name appsvr -p 80:8080 -v $(pwd)/build/libs/template-artifactid.ear:/usr/local/tomee/webapps/template-artifactid.ear tomee:8-jre-7.1.0-plus


# Java EE 8 servers
#docker run --rm --name appsvr -p 80:8080 -v $(pwd)/build/libs/template-artifactid.ear:/opt/jboss/wildfly/standalone/deployments/template-artifactid.war jboss/wildfly:14.0.0.Final /opt/jboss/wildfly/bin/standalone.sh --server-config=standalone-full.xml -b "0.0.0.0" -Dee8.preview.mode=true
#docker run --rm --name appsvr -p 80:8080 -v $(pwd)/build/libs/template-artifactid.ear:/glassfish5/glassfish/domains/domain1/autodeploy/template-artifactid.war oracle/glassfish:5.0
#docker run --rm --name appsvr -p 80:8080 -v $(pwd)/build/libs/template-artifactid.ear:/opt/payara5/glassfish/domains/domain1/autodeploy/template-artifactid.war payara/server-full:5-SNAPSHOT