#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project and runs system-test.
# System-test deploy on Wildfly within Docker.

test_gradle_jee7_ear_on_wildfly_docker() {
    cd_test_workspace

    jz project:create myapp --ear
    (
        cd myapp
        ./gradlew --console=plain build
        prepare_for_docker_volume_mount myapp-ear/build/libs
    )
    jz project:create myapp --st
    (
        cd myapp-st
        ./gradlew --console=plain systemTestInDockerEnv
        assertEquals 0 $?
    )
}
. ./shunit2
