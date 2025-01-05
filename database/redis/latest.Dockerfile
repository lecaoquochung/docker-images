# https://github.com/redis/docker-library-redis/blob/e5650da99bb377b2ed4f9f1ef993ff24729b1c16/7.4/debian/Dockerfile
# https://hub.docker.com/_/redis/tags
FROM redis:latest

LABEL org.opencontainers.image.description DESCRIPTION="Redis latest"
LABEL org.opencontainers.image.source=https://github.com/lecaoquochung/docker-images/blob/main/ubuntu/latest.Dockerfile
LABEL org.opencontainers.image.licenses=MIT

# Update package index and install dependencies
RUN apt-get update && \
    apt-get install -y git curl iputils-ping telnet vim unzip

RUN apt-get update && apt-get install -y locales 
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen