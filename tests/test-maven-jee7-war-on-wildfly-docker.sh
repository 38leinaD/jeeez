#!/usr/bin/env bash
source $TEST_ROOT/common.sh

# Creates a Java EE 7 WAR project and runs system-test.
# System-test deploy on Wildfly within Docker.

jz project:create myapp --build=maven
(
    cd myapp
    ./mvnw package
    prepare_for_docker_volume_mount target
)
jz project:create myapp --build=maven --st
(
    cd myapp-st
    ./mvnw verify
)