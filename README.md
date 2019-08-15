# capi-sidecar-samples

Sample apps demonstrating how to use [sidecar processes](http://v3-apidocs.cloudfoundry.org/version/release-candidate/#sidecars) in Cloud Foundry.

## Apps
This repository currently contains the following sample apps and sidecars.

You can quickly deploy both apps by targeting your Cloud Foundry api using the `cf cli` and running the respective script.

### config-server-sidecar
A simple Golang binary that emulates a "configuration server" for the parent app to call out to.

### wiremock-sidecar
A simple java app that uses the [wiremock framework](http://wiremock.org/) to respond with a stubbed response. 

### sidecar-dependent-app
A simple Sinatra app that calls out to the `config-server-sidecar` binary and echoes back its response.

Script: push_sample_app_with_sidecar

### sidecar-dependent-java-app
A simple Spring Boot app that calls out to the `config-server-sidecar` binary and echoes back its response.
**Note** that the manifest reserves some memory for the sidecar - if this is not specified, the Java Buildpack will consume all available memory allocated to the app.

Script: push_java_app_with_binary_sidecar

### wiremock-dependent-java-app
A simple Spring Boot app that calls out to the `wiremock-sidecar` and echoes back its response. 

Script: push_java_app_with_wiremock_sidecar