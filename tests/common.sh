#!/usr/bin/env bash
set -o pipefail # pipe fails with first failing command
set -o errexit # exit script on failed command

RESTORE='\033[0m'
RED='\033[00;91m'
WHITE='\E[1;37m'
GREEN='\033[00;92m'
CYAN='\E[1;36m'

export DIR=$(pwd)
function teardown {
    if [ -f $DIR/process.pid ]; then
        echo "EXITING; Stopping background-process..."
        kill -9 $(cat $DIR/process.pid) || true
    fi
}
trap teardown EXIT

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
    export JBOSS_PIDFILE=$DIR/process.pid
    (
        cd $JBOSS_HOME/bin
        nohup ./standalone.sh -c standalone-full.xml &
    )
}