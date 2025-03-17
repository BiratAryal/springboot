package com.birataryal.springapp;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class springappcontroller {
    
    @Value("${spring.application.name}")
    private String appName;

    @Value("${server.port}")
    private String port;

    @Value("${spring.profiles.active}")
    private String profile;

    // @RequestMapping("/api")
    // @GetMapping("/api")
    // @ResponseBody
    // public String hello() {
    //     return String.format("%s | Profile: %s | Port %s", appName,profile, port);
    // }

    @GetMapping("/api")
    public String greetings(Model model) {
        model.addAttribute("appName", appName);
        model.addAttribute("profile", profile);
        model.addAttribute("port", port);
        return "api";
    }   
}