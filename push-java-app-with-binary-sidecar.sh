#!/usr/bin/env bash

set -ex

JAVA_APP_PATH="sidecar-dependent-java-app"
JAVA_APP_MANIFEST_PATH="manifest.yml"
JAVA_APP_JAR="build/libs/sidecar-dependent-java-app-0.0.1-SNAPSHOT.jar"
CONFIG_SERVER_SIDECAR_PATH="config-server-sidecar"

function clean() {
    pushd ${JAVA_APP_PATH} > /dev/null
        ./gradlew clean
    popd > /dev/null
}

function build_config_server() {
    pushd ${CONFIG_SERVER_SIDECAR_PATH} > /dev/null
        GOOS=linux GOARCH=amd64 go build -o config-server .
    popd > /dev/null
    #cp "${CONFIG_SERVER_SIDECAR_PATH}/config-server" ${SAMPLE_APP_PATH}
}

function push_java_app_with_sidecars() {
    pushd ${JAVA_APP_PATH} > /dev/null
        ./gradlew build
        zip "${JAVA_APP_JAR}" -u "../${CONFIG_SERVER_SIDECAR_PATH}/config-server"
        cf v3-create-app sidecar-dependent-java-app
        cf v3-apply-manifest -f "${JAVA_APP_MANIFEST_PATH}"
        cf v3-push sidecar-dependent-java-app -p build/libs/sidecar-dependent-java-app-0.0.1-SNAPSHOT.jar
    popd > /dev/null
}

function main() {
    clean
    build_config_server   # go-binary sidecar server
    push_java_app_with_sidecars
}

main
