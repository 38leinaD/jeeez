#!/bin/bash

if [ -f build.gradle ]; then

    cat << EOF >> build.gradle
    
// Integration-Tests with Arquillian
dependencies {
    testCompile 'org.arquillian.container:arquillian-chameleon-junit-container-starter:1.0.0.CR2'
    testCompile 'org.arquillian.container:arquillian-chameleon-file-deployment:1.0.0.CR2'
    testCompile "org.jboss.arquillian.graphene:graphene-webdriver:2.3.2"
}

task integrationTest(type: Test) {
    group 'verification'
    description 'Run integration-tests'
    dependsOn 'build'
    include '**/*IT.class'
    systemProperties = [
        "arq.extension.webdriver.browser": "chrome",
        //"arq.extension.webdriver.chromeDriverBinary": "",
    ]
}
EOF

    
else
    echo "!! Manual steps required !!"
fi