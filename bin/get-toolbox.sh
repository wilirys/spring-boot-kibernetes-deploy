#!/bin/bash
# A quick script to install Docker Engine and Compose
# Run with sudo

# Install Docker Engine
curl -sSL https://get.docker.com/ | sh

# Start Docker
service docker start

# Install Docker Compose
curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
usermod -aG docker $(who am i | awk '{print $1}')