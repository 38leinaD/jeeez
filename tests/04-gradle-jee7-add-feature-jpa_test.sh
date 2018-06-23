#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project and addes JPA feature.
test_gradle_jee7_war_on_liberty_docker() {
    cd $TEST_WORKSPACE
    
    # Run system-test against Wildfly
    jz project:create myapp
    jz project:create myapp --st
    jz project:add myapp jpa
    (
        cd myapp
        ./gradlew --console=plain build
        assertEquals 0 $?
    )
    (
        cd myapp-st
        ./gradlew --console=plain systemTest -PcomposeFile=docker-compose.wildfly.jpa.yml
        assertEquals 0 $?
    )
    
}

. ./shunit2
