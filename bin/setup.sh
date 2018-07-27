#!/bin/bash
# A quick script to install environment

echo -----------------------
echo Install Minikube
echo
/bin/bash ./get-minikube.sh
echo -----------------------

echo -----------------------
echo Install Docker Toolbox
echo
/bin/bash ./get-toolbox.sh
echo -----------------------

echo -----------------------
echo Install Kubectl
echo
/bin/bash ./get-kubectl.sh
echo -----------------------