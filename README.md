#### Deploying Spring-Boot application into Kibernetes cluster

**What is needed?**
* Minikube - https://github.com/kubernetes/minikube
* Kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl/
* Docker - https://docs.docker.com/toolbox/toolbox_install_mac/ (Use script from **bin** folder to install toolbox  on linux)

**1. Simple Spring MVC Controller and Docker Image build with Spotify maven plugin**

```java
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
```






