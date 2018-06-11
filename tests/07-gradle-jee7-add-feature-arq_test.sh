#!/usr/bin/env bash
. ./common.sh

# Creates a Java EE 7 WAR project and addes Arquillian feature.
test_gradle_jee7_feature_arquillian() {
    cd $TEST_WORKSPACE
    
    # Run system-test against Wildfly
    jz project:create myapp
    jz project:add myapp arq
    (
        cd myapp
        ./gradlew --console=plain --info integrationTest
        assertEquals 0 $?
    )    
}

. ./shunit2
