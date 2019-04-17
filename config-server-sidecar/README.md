# Sample "Config Server" Sidecar Process

This is a simple Golang "config server" designed to be used along with the sample `sidecar-dependent-app`.
It listens on `localhost:$CONFIG_SERVER_PORT/config/` and returns some hard coded "configuration" for the parent app to consume.


## Building the binary
```
GOOS=linux GOARCH=amd64 go build -o config-server .
```

## Running the config server
```
CONFIG_SERVER_PORT=8082 ./config-server
```
