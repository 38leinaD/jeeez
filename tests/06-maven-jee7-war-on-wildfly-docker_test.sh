#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project and runs system-test.
# System-test deploy on Wildfly within Docker.

test_maven_jee7_ear_on_wildfly_docker() {
    cd_test_workspace

    jz project:create myapp --maven
    (
        cd myapp
        ./mvnw package
        prepare_for_docker_volume_mount target
        ./mvnw install
    )
}
. ./shunit2
