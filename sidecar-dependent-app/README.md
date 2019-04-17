# Sample Sidecar-Dependent App

This is a simple Sinatra-based Ruby app that calls out to a co-located `config-server` sidecar process to retrieve its "configuration."

## Endpoints
* `GET /config` will echo back any configuration retrieved from the `config-server` sidecar
