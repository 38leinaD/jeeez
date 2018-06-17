#!/bin/bash

if [ -f build.gradle ]; then

    cat << EOF >> build.gradle
    
// UI-Tests with Arquillian
dependencies {
    testCompile 'org.jboss.arquillian:arquillian-bom:1.4.0.Final'
    testCompile 'org.jboss.arquillian.junit:arquillian-junit-container'
    testCompile "org.jboss.arquillian.graphene:graphene-webdriver:2.3.2"
}
EOF

    
else
    echo "!! Manual steps required !!"
fi