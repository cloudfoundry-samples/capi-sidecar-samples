_#!/usr/bin/env bash

set -e

APP_NAME="wiremock-dependent-java-app"
JAVA_APP_PATH="wiremock-dependent-java-app"
JAVA_SIDECAR_PATH="java-config-server-sidecar"
JAVA_APP_MANIFEST_PATH="manifest.yml"
JAVA_APP_JAR="build/libs/wiremock-dependent-java-app-0.0.1-SNAPSHOT.jar"
JAVA_CONFIG_JAR="build/libs/java-config-server-sidecar-0.0.1-SNAPSHOT.jar"

function clean() {
    cf delete -f "${APP_NAME}"
    pushd ${JAVA_APP_PATH} > /dev/null
        ./gradlew clean
    popd > /dev/null
    pushd ${JAVA_SIDECAR_PATH} > /dev/null
        ./gradlew clean
    popd > /dev/null
}

function build_java_config_server() {
    pushd ${JAVA_SIDECAR_PATH} > /dev/null
        ./gradlew build
        cp build/libs/*.jar "../${JAVA_APP_PATH}/build/libs"
    popd > /dev/null
}

function build_java_app() {
    pushd ${JAVA_APP_PATH} > /dev/null
        ./gradlew build
    popd > /dev/null
}

function push_java_app_with_java_sidecars() {
    pushd ${JAVA_APP_PATH} > /dev/null
      zip "${JAVA_APP_JAR}" -u "${JAVA_CONFIG_JAR}"
      cf v3-create-app "${APP_NAME}"
      cf v3-apply-manifest -f "${JAVA_APP_MANIFEST_PATH}"
      cf v3-push "${APP_NAME}" \
                -p "build/libs/wiremock-dependent-java-app-0.0.1-SNAPSHOT.jar" \
                -b java_buildpack
    popd > /dev/null
}

function main() {
    clean
    build_java_app
    build_java_config_server
    push_java_app_with_java_sidecars
}

main
