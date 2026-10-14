#!/usr/bin/env bash

set -e

check_case() {
    local usage="$1"
    local expected_status="$2"
    local expected_message="$3"
    local output
    local status

    if output=$(bash system_check.sh "$usage" 2>&1); then
        status=0
    else
        status=$?
    fi

    if [[ "$status" -ne "$expected_status" ]]; then
        echo "FAIL: Unexpected exit code for '$usage'"
        echo "Expected: $expected_status, got: $status"
        exit 1
    fi

    if [[ "$output" != *"$expected_message"* ]]; then
        echo "FAIL: Unexpected message for '$usage'"
        exit 1
    fi

    echo "PASS: '$usage' behaves as expected"
}

check_case 79 0 "OK: disk usage is below 80%"
check_case 80 1 "Warning: disk usage is at least 80%"
check_case abc 2 "Error: disk usage must be a number between 0 and 100"
check_case 150 2 "Error: disk usage must be a number between 0 and 100"

echo "All tests passed!"
