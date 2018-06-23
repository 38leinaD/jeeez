#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project, installs Wildfly locally and deploys.
# System-test are then run against local Wildfly.

testPayaraInstall() {
    cd $TEST_WORKSPACE
    # Install Wildfly
    jz payara:install
    source .jeeez

    # Build webapp and copy to deploy folder
    jz project:create myapp
    (
        cd myapp
        ./gradlew --console=plain deployWar
    )

    (
        cd $PAYARA_HOME/bin
        ./asadmin start-domain
    )

    wait_for_endpoint http://localhost:8080/myapp/resources/health

    # Run system-test
    jz project:create myapp --st
    (
        cd myapp-st
        export APPSVR_HTTP_PORT=8080
        ./gradlew --console=plain systemTestClientOnly
        assertEquals 0 $?
    )
}

tearDown() {
    cd $PAYARA_HOME/bin
    ./asadmin stop-domain
}

. ./shunit2