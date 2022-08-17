#!/usr/bin/env bash
clear

docker run --rm \
           -e BROWSER=chrome \
           -e USERNAME="User1" \
           -e ACCESS_TOKEN="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" \
           -e ROBOT_OPTIONS="--loglevel INFO" \
           --user=root \
           --net=host \
           -v "$PWD/output":/output \
           -v "$PWD/suites":/opt/robotframework/tests:Z \
           -v "$PWD/scripts":/scripts \
           -v "$PWD/reports":/opt/robotframework/reports:Z \
           --security-opt seccomp:unconfined \
           --shm-size "1g" \
           robotframework:latest