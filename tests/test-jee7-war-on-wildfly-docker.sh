#!/usr/bin/env bash

jz project:create myapp
(
    cd myapp
    ./gradlew build
)
jz project:create myapp --st
(
    cd myapp-st
    ./gradlew systemTestInDockerEnv
)