_#!/usr/bin/env bash

set -e

APP_NAME="sidecar-dependent-java-app"
JAVA_APP_PATH="sidecar-dependent-java-app"
JAVA_APP_MANIFEST_PATH="manifest.yml"
JAVA_APP_JAR="build/libs/sidecar-dependent-java-app-0.0.1-SNAPSHOT.jar"
CONFIG_SERVER_SIDECAR_PATH="config-server-sidecar"

function clean() {
    cf delete -f "${APP_NAME}"
    rm "${CONFIG_SERVER_SIDECAR_PATH}/config-server"
    pushd ${JAVA_APP_PATH} > /dev/null
        ./gradlew clean
    popd > /dev/null
}

function build_config_server() {
    pushd ${CONFIG_SERVER_SIDECAR_PATH} > /dev/null
        GOOS=linux GOARCH=amd64 go build -o config-server .
    popd > /dev/null
}

function build_java_app() {
    pushd ${JAVA_APP_PATH} > /dev/null
        ./gradlew build
    popd > /dev/null
}

function push_java_app_with_sidecars() {
    zip "${JAVA_APP_PATH}/${JAVA_APP_JAR}" -u "${CONFIG_SERVER_SIDECAR_PATH}/config-server"
    cf v3-create-app "${APP_NAME}"
    cf v3-apply-manifest -f "${JAVA_APP_PATH}/${JAVA_APP_MANIFEST_PATH}"
    cf v3-push "${APP_NAME}" \
                -p "${JAVA_APP_PATH}/build/libs/sidecar-dependent-java-app-0.0.1-SNAPSHOT.jar" \
                -b java_buildpack
}

function main() {
    clean
    build_config_server
    build_java_app
    push_java_app_with_sidecars
}

main
