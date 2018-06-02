#!/usr/bin/env bash
set -o pipefail # pipe fails with first failing command
set -o errexit # exit script on failed command

source common.sh

export TEST_ROOT=${JZ_ROOT:-"$(dirname "$(readlink -f "$0")")"}
export PATH=$PATH:$(realpath $(pwd)/..)

run_testcase() {
    local testcase=$1
    export TEST_WORKSPACE=$(mktemp -d)
    export TEST_SCRIPT=$(realpath $testcase)
    echo "=========================================================================================="
    echo "Running test-case $testcase (TEST_WORKSPACE=$TEST_WORKSPACE)..."

    (
        cd $TEST_WORKSPACE
        bash $TEST_SCRIPT && echo -e "${GREEN}[PASSED]${RESTORE}" || echo -e "${RED}[FAILED]${RESTORE}"
    )
    rm -rf $TEST_WORKSPACE
    echo "=========================================================================================="

}

run_all_testcases() {
    for testcase in test-*.sh; do
        run_testcase $testcase
    done
}

list_all_testcases() {
    for testcase in test-*.sh; do
        echo "$testcase"
    done
}

if [ "$1" == "" ]; then
    run_all_testcases
else
    run_testcase $1
fi
