#!/usr/bin/env bash
source $TEST_ROOT/common.sh

export DIR=$(pwd)
function teardown {
    if [ -f $DIR/process.pid ]; then
        echo "EXITING; Stopping background-process..."
        kill -9 $(cat $DIR/process.pid) || true
    fi
}
trap teardown EXIT

# Install Wildfly
jz wildfly:install
source .jeeez

# Build webapp and copy to Wildfly deploy folder
jz project:create myapp
(
    cd myapp
    export DEPLOY_TO=$JBOSS_HOME/standalone/deployments
    ./gradlew deployWar
)

# Start Wildfly
export LAUNCH_JBOSS_IN_BACKGROUND=1
export JBOSS_PIDFILE=$DIR/process.pid
(
    cd $JBOSS_HOME/bin
    nohup ./standalone.sh -c standalone-full.xml &
)

wait_for_endpoint http://localhost:8080/myapp/resources/health

# Run system-test against Wildfly
jz project:create myapp --st
(
    cd myapp-st
    export APPSVR_HTTP_PORT=8080
    ./gradlew systemTest
)

