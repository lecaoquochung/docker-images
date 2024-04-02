#!/bin/bash

# Define service directories or Dockerfile names
services=("service1" "service2")

# Loop through each service and build its Docker image
for service in "${services[@]}"; do
  docker build -t "${service}-image-name" "./${service}"
  # Or for single directory: docker build -f "Dockerfile.${service}" -t "${service}-image-name" .
done