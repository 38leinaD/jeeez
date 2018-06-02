#!/usr/bin/env bash

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