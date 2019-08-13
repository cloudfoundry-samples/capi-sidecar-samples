package org.cloudfoundry.javadora;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    @RequestMapping("/")
    public String greeting() {
         return "Hello I am a wiremock sidecar dependent java app.  Visit <a href=\"/config\">the config endpoint</a> to see me retrieve a value from my sidecar!";
    }
}
