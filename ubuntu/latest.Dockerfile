# Use the official base image
FROM ubuntu:latest

# https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#labelling-container-images
# LABEL org.opencontainers.image.description="Ubuntu latest"
LABEL org.opencontainers.image.description DESCRIPTION="Ubuntu latest"
LABEL org.opencontainers.image.source=https://github.com/lecaoquochung/docker-images/blob/main/ubuntu/latest.Dockerfile
LABEL org.opencontainers.image.licenses=MIT

# Update package index and install dependencies
RUN apt-get update && \
    apt-get install -y git curl iputils-ping telnet vim unzip

# WORKDIR /home/qa/code
# COPY ./build/$CURRENT_BRANCH/dependencies.sh .
# RUN chmod +x dependencies.sh

# # Verify dependencies
# CMD ["./dependencies.sh"]