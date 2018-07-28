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

**2. Docker**

* Before building the image run: 
```bash
eval $(minikube docker-env)
```
* The next step is run
```bash 
mvn clean install
```
This will build the app JAR and docker image.
To check that we doing all right, let's run the next command
```bash 
docker image
```
We'll should see images of the kibernetes cluster components including our image **test-comtroller:1.0-SNAPSHOT**
```bash
earthmor@pxbox:~/spring-boot-kibernetes-deploy$ docker images
REPOSITORY                                 TAG                 IMAGE ID            CREATED             SIZE
test-controller                            1.0-SNAPSHOT        0c274217d95b        2 minutes ago       640MB
openjdk                                    latest              8c80ddf988c8        11 days ago         624MB
k8s.gcr.io/kube-proxy-amd64                v1.10.0             bfc21aadc7d3        4 months ago        97MB
k8s.gcr.io/kube-apiserver-amd64            v1.10.0             af20925d51a3        4 months ago        225MB
k8s.gcr.io/kube-scheduler-amd64            v1.10.0             704ba848e69a        4 months ago        50.4MB
k8s.gcr.io/kube-controller-manager-amd64   v1.10.0             ad86dbed1555        4 months ago        148MB
k8s.gcr.io/etcd-amd64                      3.1.12              52920ad46f5b        4 months ago        193MB
k8s.gcr.io/kube-addon-manager              v8.6                9c16409588eb        5 months ago        78.4MB
k8s.gcr.io/k8s-dns-dnsmasq-nanny-amd64     1.14.8              c2ce1ffb51ed        6 months ago        41MB
k8s.gcr.io/k8s-dns-sidecar-amd64           1.14.8              6f7f2dc7fab5        6 months ago        42.2MB
k8s.gcr.io/k8s-dns-kube-dns-amd64          1.14.8              80cc5ea4b547        6 months ago        50.5MB
k8s.gcr.io/pause-amd64                     3.1                 da86e6ba6ca1        7 months ago        742kB
k8s.gcr.io/kubernetes-dashboard-amd64      v1.8.1              e94d2f21bc0c        7 months ago        121MB
gcr.io/k8s-minikube/storage-provisioner    v1.8.1              4689081edb10        8 months ago        80.8MB

```

**3. Kibernetes**
* I suppose you started the minikube by 
```bash 
minikube start
```
* To verify that minikube local kubernetes cluster is up, just perform the following command
```bash
kubectl cluster-info
```
Let's see on result
```bash
earthmor@pxbox:~/spring-boot-kibernetes-deploy$ kubectl cluster-info
Kubernetes master is running at https://192.168.99.100:8443
KubeDNS is running at https://192.168.99.100:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

Before to start next steps I recommend to be familiar with the terms Deployment, Pod and Service. 
You can start from https://kubernetes.io/docs/concepts/

**4. Deployment**

In the root directory of project run
```bash
kubectl create -f deployment.yaml
```
and verify that deployment is installed and Pods is running
```bash
earthmor@pxbox:~/spring-boot-kibernetes-deploy$ kubectl get pods
NAME                        READY     STATUS    RESTARTS   AGE
test-app-64f8b5bfcd-lzjq4   1/1       Running   17         17h
```

So, to access the _Deployment_ test-app externaly, we need to install kubernetes service for that.

**5. Service**

To install the service run
```bash
kubectl create -f service.yaml
```
and let's see on result
```bash
earthmor@pxbox:~/spring-boot-kibernetes-deploy$ kubectl get services
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP          18h
test-app     NodePort    10.106.40.242   <none>        8081:32443/TCP   16h
```

**6. Accessing the Deployment Externally**

To get the url for the service we need to perform the next command
```bash
earthmor@pxbox:~/spring-boot-kibernetes-deploy$ minikube service test-app --url
http://192.168.99.100:32443
```

Now we have an IP address. Let's check our simple controller.
```bash
earthmor@pxbox:~/spring-boot-kibernetes-deploy$ curl http://192.168.99.100:32443/say_hello
Hello my majesty
```

Okay, we have successfully deployed spring-boot application into kubernetes...Cheers.