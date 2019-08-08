package org.cloudfoundry.javadora;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class ConfigController {
    @Value("${CONFIG_SERVER_PORT:8082}")
    private String port;
    @RequestMapping("/config")
    public String greeting() {
        final String uri = "http://localhost:" + port + "/config";
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(uri, String.class);
    }
}