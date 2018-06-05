#!/usr/bin/env bash

export PATH=$PATH:$(pwd)/..
export TEST_WORKSPACE=$(mktemp -d)

wait_for_endpoint() {
    local endpoint=$1
    local attempt_counter=0
    local max_attempts=5
    until $(curl --output /dev/null --silent --head --fail $endpoint); do
        if [ ${attempt_counter} -eq ${max_attempts} ];then
            echo "Max attempts reached."
            exit 1
        fi
        echo "wait_for_endpoint $endpoint..."
        attempt_counter=$(($attempt_counter+1))
        sleep 5
    done
}

start_wildfly_in_background() {
    export LAUNCH_JBOSS_IN_BACKGROUND=1
    export JBOSS_PIDFILE=$TEST_WORKSPACE/process.pid
    (
        cd $JBOSS_HOME/bin
        nohup ./standalone.sh -c standalone-full.xml &
    )
}


# To be able to access the from within a mounted docker-volume, make it accessible for all users.
# This is required e.g. on travis where the travis-user has uid=2000 but the container-process of wildfly uid=1000.
# Without this, the the container would not be able to read files within the folder.
prepare_for_docker_volume_mount() {
    chmod -R 777 $1
}

cd_test_workspace() {
    cd $TEST_WORKSPACE
    pwd
}