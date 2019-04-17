#!/usr/bin/env bash

SAMPLE_APP_PATH="sidecar-dependent-app"
CONFIG_SERVER_SIDECAR_PATH="config-server-sidecar"

function clean() {
    rm "${SAMPLE_APP_PATH}/config-server"
    rm "${CONFIG_SERVER_SIDECAR_PATH}/config-server"
}

function build_config_server() {
    pushd ${CONFIG_SERVER_SIDECAR_PATH} > /dev/null
        GOOS=linux GOARCH=amd64 go build -o config-server .
    popd > /dev/null
    cp "${CONFIG_SERVER_SIDECAR_PATH}/config-server" ${SAMPLE_APP_PATH}
}

function push_app_with_sidecars() {
    pushd ${SAMPLE_APP_PATH} > /dev/null
      cf v3-create-app sidecar-dependent-app
      cf v3-apply-manifest -f manifest.yml
      cf v3-push sidecar-dependent-app
    popd > /dev/null
}

function main() {
    clean
    build_config_server
    push_app_with_sidecars
}

main
