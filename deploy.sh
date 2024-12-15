#!/bin/bash
# Pull the Docker image from Docker Hub
docker pull docker1/dev:dev1

# Stop and remove the old container (if exists)
docker stop container1 || true
docker rm container1 || true

# Run the new container
docker run -d --name container1 -p 8080:8080 docker1/dev:dev1
