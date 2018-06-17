#!/usr/bin/env bash
. ./common.sh

# Create UI System-Tests
test_gradle_jee7_feature_arquillian() {
    cd $TEST_WORKSPACE
    
    # Run system-test against Wildfly
    jz project:create myapp
    jz project:create myapp --st
    jz project:add myapp arq
    (
        cd myapp
        ./gradlew --console=plain --info build
        assertEquals 0 $?
    )    
    (
        cd myapp-st
        ./gradlew --console=plain --info systemTestInDockerEnv
        assertEquals 0 $?
    )
}

. ./shunit2
