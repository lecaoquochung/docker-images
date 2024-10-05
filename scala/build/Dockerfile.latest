# Release: https://releases.ubuntu.com
# Wiki: https://wiki.ubuntu.com/Releases
# FROM ubuntu:oracular
FROM ubuntu:24.10

# Maintainer information
LABEL maintainer="me@lehungio.com"

# Docker Engine https://docs.docker.com/engine/
ARG DOCKER_VERSION=27.3
ARG DOCKER_COMPOSE_VERSION=2.29.7
ARG AWS_CLI_VERSION=2.13.5
ARG QA_PATH="/home/qa/code"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive  
ENV PATH="/home/qa/.yarn/bin:/home/qa/.local/bin:${PATH}"  
ENV QA_PATH=${QA_PATH}

# Update package index and install system dependencies
RUN apt-get update && apt-get install -y \
    git curl iputils-ping telnet vim gnupg unzip wget python3 python3-venv \
    postgresql-client default-jre default-jdk apt-transport-https ca-certificates \
    software-properties-common chromium-bsu chromium-browser xvfb python3-full \
    make build-essential
# TODO Build by installing package with specific version
# RUN apt-get update && apt-get install -y --no-install-recommends \  
#     git=1:2.34.1-1ubuntu1.10 \  
#     curl=7.81.0-1ubuntu1.15 \  
#     iputils-ping=3:20211215-1 \  
#     telnet=0.17-44build1 \  
#     vim=2:8.2.3995-1ubuntu2.15 \  
#     gnupg=2.2.27-3ubuntu2.1 \  
#     unzip=6.0-26ubuntu3.1 \  
#     wget=1.21.2-2ubuntu1 \  
#     python3=3.10.6-1~22.04 \  
#     python3-venv=3.10.6-1~22.04 \  
#     postgresql-client=14+238 \  
#     default-jre=2:1.11-72build2 \  
#     default-jdk=2:1.11-72build2 \  
#     apt-transport-https=2.4.10 \  
#     ca-certificates=20230311ubuntu0.22.04.1 \  
#     software-properties-common=0.99.22.9 \  
#     chromium-browser=120.0.6099.129-0ubuntu0.22.04.1 \  
#     xvfb=2:21.1.4-2ubuntu1.7~22.04.1 \  
#     python3-full=3.10.6-1~22.04 \  
#     make=4.3-4.1build1 \  
#     build-essential=12.9ubuntu3 \  
#     && rm -rf /var/lib/apt/lists/*  

# Create a virtual environment
# Activate the virtual environment
# Upgrade pip within the virtual environment
# Copy the requirements file into the container
# Install dependencies from the requirements file
# RUN python3 -m venv /venv
# ENV PATH="/venv/bin:$PATH"
# RUN pip install --upgrade pip
# COPY scala/build/requirements.txt .
# RUN pip install -r requirements.txt
COPY scala/build/requirements.txt /tmp/requirements.txt
RUN python3 -m venv /venv && \
    . /venv/bin/activate && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt
ENV PATH="/venv/bin:$PATH"


# Install Yarn
# Install Node.js and utilities
# RUN npm install -g npm@latest
# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#     echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
#     apt-get update && \
#     apt-get install -y yarn
# RUN apt-get install -y nodejs npm && \
#     npm install -g n
# RUN n stable

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    # apt-get install -y --no-install-recommends yarn=<version> nodejs=<version> npm=<version> && \
    # apt-get install -y --no-install-recommends yarn=1.22.22 nodejs=22.9.0 npm=10.9.0 && \
    apt-get install -y --no-install-recommends yarn nodejs npm && \
    npm install -g n && \
    n 22.9.0 && \
    npm cache clean --force && \
    yarn cache clean && \
    rm -rf /var/lib/apt/lists/*

# TODO - update to yarn 2
# https://yarnpkg.com/getting-started/install

# Install AWS CLI
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
#     unzip awscliv2.zip && \
#     ./aws/install && \
#     rm -rf awscliv2.zip ./aws
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip ./aws

# Install Docker and Docker Compose
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# TODO build docker engine with specific version
# https://docs.docker.com/engine/install/ubuntu/
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
#     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends \
#     docker-ce=${DOCKER_VERSION} \
#     docker-ce-cli=${DOCKER_VERSION} \
#     containerd.io && \
#     curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#     chmod +x /usr/local/bin/docker-compose && \
#     rm -rf /var/lib/apt/lists/*
# Logs: https://github.com/lecaoquochung/docker-images/pull/25#discussion_r1788462147

# RUN apt-get update && \
#     apt-get install -y \
#         ca-certificates \
#         curl \
#         gnupg \
#         lsb-release && \
#     mkdir -p /etc/apt/keyrings && \
#     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
#     echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
#         tee /etc/apt/sources.list.d/docker.list > /dev/null && \
#     apt-get update && \
#     apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# LOGS: docker compose / docker-compose

# Setup application directory
RUN mkdir -p /home/qa/Downloads /app /home/qa/code && \
chown -R 1000:1000 /home/qa

# Set work directory
WORKDIR /home/qa/code

# Install Node & Yarn dependencies
RUN yarn install && \
    yarn global add junit-report-merger && \
    yarn cache clean

# Install trcli and Playwright
RUN pip install --no-cache-dir trcli && \
    npx playwright install

# Version check and other commands
# RUN date && pwd && ls && \
#     docker --version && \
#     npm --version && \
#     yarn --version && \
#     trcli && \
#     npx playwright --version
# TODO CI build test
# RUN yarn install && \
#     yarn global add junit-report-merger && \
#     yarn cache clean && \
#     pip install --no-cache-dir trcli && \
#     npx playwright install && \
#     docker --version && \
#     npm --version && \
#     yarn --version && \
#     trcli --version && \
#     npx playwright --version
# Check Available Package Versions:
# If you prefer to specify exact versions, you can list available versions for docker-ce and docker-ce-cli using the following commands:
# apt-cache madison docker-ce
# apt-cache madison docker-ce-cli

# Start command (example: running a server, for instance)
CMD ["bash"]

# This build is for testing purpose only
# For production application with scala
# Replace /app/your-scala-app.jar with the actual path to your Scala application's JAR file.
# CMD ["java", "-jar", "/app/your-scala-app.jar"]
# Alternatively, you could use an ENTRYPOINT script that performs any necessary setup and then runs your application:
# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]