#!/bin/bash
set -e

./gradlew build
docker run --rm --name appsvr -p 80:8080 -v $(pwd)/template-artifactid-ear/build/libs/template-artifactid.ear:/opt/jboss/wildfly/standalone/deployments/template-artifactid.ear jboss/wildfly:10.1.0.Final /opt/jboss/wildfly/bin/standalone.sh --server-config=standalone-full.xml -b "0.0.0.0"
#docker run --rm --name appsvr -p 80:9080 -p 443:9443 -v $(pwd)/template-artifactid-ear/build/libs/template-artifactid.ear:/config/dropins/template-artifactid.ear websphere-liberty:javaee7
#docker run --rm --name appsvr -p 9060:9060 -p 80:9080 -p 7777:7777 -v $(pwd)/template-artifactid-ear/build/libs/template-artifactid.ear:/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/monitoredDeployableApps/servers/server1/template-artifactid.ear 38leinad/websphere-9