#!/usr/bin/env bash
set -o pipefail # pipe fails with first failing command
set -o errexit # exit script on failed command

RESTORE='\033[0m'
RED='\033[00;91m'
WHITE='\E[1;37m'
GREEN='\033[00;92m'
CYAN='\E[1;36m'

echo "Print uid/guid:"
id

export TEST_ROOT=${JZ_ROOT:-"$(dirname "$(readlink -f "$0")")"}
export PATH=$PATH:$(pwd)/..

num_tests=0
num_failed_tests=0
num_passed_tests=0

function test_passed() {
    echo -e "${GREEN}***** [PASSED] *****${RESTORE}"
    num_tests=$(($num_tests+1))
    num_passed_tests=$(($num_passed_tests+1))
}

function test_failed() {
    echo -e "${RED}***** [FAILED] *****${RESTORE}"
    num_tests=$(($num_tests+1))
    num_failed_tests=$(($num_failed_tests+1))
}

run_testcase() {
    local testcase=$1
    export TEST_WORKSPACE=$(mktemp -d)
    export TEST_SCRIPT=$(pwd)/$testcase
    echo "*******************************************************************************************"
    echo "Running test-case $testcase (TEST_WORKSPACE=$TEST_WORKSPACE)..."

    pushd $TEST_WORKSPACE
    bash $TEST_SCRIPT && test_passed || test_failed
    [[ -v keep_failed ]] || rm -rf $TEST_WORKSPACE
    popd
    echo "*******************************************************************************************"
}

run_all_testcases() {
    for testcase in test-*.sh; do
        run_testcase $testcase
    done
}

while [ $# -gt 0 ]; do
    case "$1" in
        --keep-failed)
        keep_failed=1
        ;;
        --*)
        echo "Invalid argument"
        exit 1
        ;;
        *)
        break
    esac
    shift
done

if [ "$1" == "" ]; then
    run_all_testcases
else
    run_testcase $1
fi

if [ "$num_failed_tests" -eq "0" ]; then
    echo -e " ${GREEN}Tests: $num_tests${RESTORE}"
    echo -e " ${GREEN}Passed tests: $num_passed_tests${RESTORE}"
    echo -e " ${GREEN}Failed tests: $num_failed_tests${RESTORE}"
    exit 0
else
    echo -e " ${RED}Tests: $num_tests${RESTORE}"
    echo -e " ${RED}Passed tests: $num_passed_tests${RESTORE}"
    echo -e " ${RED}Failed tests: $num_failed_tests${RESTORE}"
    exit 1
fi
