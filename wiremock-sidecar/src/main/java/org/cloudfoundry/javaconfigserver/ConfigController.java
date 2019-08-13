package org.cloudfoundry.javaconfigserver;


import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.client.WireMock;

import static com.github.tomakehurst.wiremock.client.WireMock.aResponse;
import static com.github.tomakehurst.wiremock.client.WireMock.get;
import static com.github.tomakehurst.wiremock.client.WireMock.stubFor;
import static com.github.tomakehurst.wiremock.client.WireMock.urlEqualTo;
import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.options;


public class ConfigController {

    public static void main(String args[]) {

        WireMockServer wireMockServer = new WireMockServer(options().port(8082));
        wireMockServer.start();
        WireMock.configureFor("localhost", wireMockServer.port());

        stubFor(get(urlEqualTo("/config"))
                .willReturn(aResponse()
                        .withBody("Hello I am the Wiremock Sidecar Config!")));

    }
}
