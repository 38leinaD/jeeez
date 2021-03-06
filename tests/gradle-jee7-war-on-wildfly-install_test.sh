#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project, installs Wildfly locally and deploys.
# System-test are then run against local Wildfly.

testWildflyInstall() {
    cd $TEST_WORKSPACE
    # Install Wildfly
    jz wildfly:install
    source .jeeez

    # Build webapp and copy to Wildfly deploy folder
    jz project:create myapp
    (
        cd myapp
        export DEPLOY_TO=$JBOSS_HOME/standalone/deployments
        ./gradlew --console=plain deployWar
    )

    start_wildfly_in_background

    wait_for_endpoint http://localhost:8080/myapp/resources/health

    # Run system-test against Wildfly
    jz project:create myapp --st
    (
        cd myapp-st
        export APPSVR_HTTP_PORT=8080
        ./gradlew --console=plain systemTestClientOnly
        assertEquals 0 $?
    )
}

tearDown() {
    kill -9 $(cat $TEST_WORKSPACE/process.pid) || true
}

. ./shunit2