#!/usr/bin/env bash
source $TEST_ROOT/common.sh

# Creates a Java EE 7 WAR project and runs system-test.
# System-test deploy on Wildfly within Docker.

jz project:create myapp
(
    cd myapp
    ./gradlew --console=plain build
)
jz project:create myapp --st
(
    cd myapp-st
    ./gradlew --console=plain systemTestInDockerEnv
)