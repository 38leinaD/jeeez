#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project and runs system-test.
# System-test deploy on Wildfly within Docker.

test_maven_jee7_war_on_tomee_docker() {
    cd $TEST_WORKSPACE

    jz project:create myapp --build=maven
    (
        cd myapp
        ./mvnw package
        prepare_for_docker_volume_mount target
    )
    jz project:create myapp --build=maven --st
    (
        cd myapp-st
        ./mvnw verify -DcomposeFile=docker-compose.tomee.yml
        assertEquals 0 $?
    )
}

. ./shunit2
