#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project and runs system-test.
# System-test deploy on Wildfly within Docker.

test_maven_jee7_war_on_tomee_docker() {
    cd $TEST_WORKSPACE

    jz project:create myapp
    (
        cd myapp
        ./gradlew --console=plain build
        prepare_for_docker_volume_mount build/libs
        ./gradlew --console=plain systemTest
        assertEquals 0 $?
    )
}
. ./shunit2
