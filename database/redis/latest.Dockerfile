# https://github.com/redis/docker-library-redis/blob/e5650da99bb377b2ed4f9f1ef993ff24729b1c16/7.4/debian/Dockerfile
# https://hub.docker.com/_/redis/tags
FROM redis:latest

LABEL org.opencontainers.image.description DESCRIPTION="Redis latest"
LABEL org.opencontainers.image.source=https://github.com/lecaoquochung/docker-images/blob/main/ubuntu/latest.Dockerfile
LABEL org.opencontainers.image.licenses=MIT

# Update package index and install dependencies
RUN apt-get update && apt-get install -y \
    locales git curl iputils-ping telnet vim unzip && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    echo "LANG=en_US.UTF-8" >> /etc/default/locale && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Expose default Redis port
EXPOSE 6379