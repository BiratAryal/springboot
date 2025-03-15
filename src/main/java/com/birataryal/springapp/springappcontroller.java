package com.birataryal.springapp;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;


@RestController
public class springappcontroller {
    
    @Value("${spring.application.name}")
    private String appName;

    @Value("${server.port}")
    private String port;

    @Value("${spring.profiles.active}")
    private String profile;

    @RequestMapping("/api")
    public String hello() {
        return String.format("%s | Profile: %s | Port %s", appName,profile, port);
    }
}
