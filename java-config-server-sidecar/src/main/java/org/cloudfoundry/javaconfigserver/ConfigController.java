package org.cloudfoundry.javaconfigserver;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ConfigController {

    @RequestMapping("/config")
    public String greeting() {
        return "Hello I'm the config server";
    }
}