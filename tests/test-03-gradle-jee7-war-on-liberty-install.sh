#!/usr/bin/env bash
source $TEST_ROOT/common.sh

# Creates a Java EE 7 WAR project, installs Wildfly locally and deploys.
# System-test are then run against local Wildfly.

function shutdownLiberty {
    cd $WLP_HOME/bin
    ./server stop
}

# Install Wildfly
jz liberty:install
source .jeeez
(
    cd $WLP_HOME/bin
    rm -rf $WLP_HOME/usr/servers/defaultServer
    ./server create --template=javaee7
)

# Build webapp and copy to Wildfly deploy folder
jz project:create myapp
(
    cd myapp
    export DEPLOY_TO=$WLP_HOME/usr/servers/defaultServer/dropins
    ./gradlew --console=plain deployWar
)

# Start Liberty with application
(
    cd $WLP_HOME/bin
    ./server start
)

trap shutdownLiberty EXIT

wait_for_endpoint http://localhost:9080/myapp/resources/health

# Run system-test against Wildfly
jz project:create myapp --st
(
    cd myapp-st
    export APPSVR_HTTP_PORT=9080
    ./gradlew --console=plain systemTest
)

