#!/bin/bash
set -e

./gradlew build

# Java EE 7 servers
docker run --rm --name appsvr -p 80:8080 -v $(pwd)/build/libs/:/opt/jboss/wildfly/standalone/deployments/ jboss/wildfly:10.1.0.Final /opt/jboss/wildfly/bin/standalone.sh --server-config=standalone-full.xml -b "0.0.0.0"
#docker run --rm --name appsvr -p 80:9080 -p 443:9443 -v $(pwd)/build/libs/:/config/dropins/ websphere-liberty:javaee7
#docker run --rm --name appsvr -p 9060:9060 -p 80:9080 -p 7777:7777 -v $(pwd)/build/libs:/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/monitoredDeployableApps/servers/server1 38leinad/websphere-9

# Java EE 8 servers
#docker run --rm --name appsvr -p 80:8080 -v $(pwd)/build/libs/:/opt/jboss/wildfly/standalone/deployments/ jboss/wildfly:12.0.0.Final /opt/jboss/wildfly/bin/standalone.sh --server-config=standalone-full.xml -b "0.0.0.0" -Dee8.preview.mode=true
