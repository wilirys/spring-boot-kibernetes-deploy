package com.kibernetes.deploy.web;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ControllerMVC {

    @RequestMapping("/say_hello")
    public String simpleMvc() {
        return "Hello my majesty";
    }
}
