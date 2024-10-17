# https://ubuntu.com/about/release-cycle
FROM ubuntu:24.04

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update package index and install basic dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        iputils-ping \
        telnet \
        vim \
        gnupg \
        unzip \
        wget \
        apt-transport-https \
        ca-certificates \
        software-properties-common \
        python3 \
        python3-venv \
        python3-pip \
        postgresql-client \
        default-jre \
        default-jdk \
        chromium-bsu \
        chromium-browser \
        xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn

# Install Node.js and npm
RUN apt-get install -y nodejs npm && \
    npm install -g n

# Install Java 11 (Amazon Corretto)
RUN wget -O- https://apt.corretto.aws/corretto.key | apt-key add - && \
    echo "deb https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list && \
    apt-get update && \
    apt-get install -y java-11-amazon-corretto-jdk

# Install sbt (version 20224.1.24 pre-installed)
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add - && \
    apt-get update && \
    apt-get install -y sbt

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip

# Install Docker and Docker Compose
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Install Playwright and dependencies for browser testing
RUN npm install -g playwright && \
    npx playwright install && \
    yarn playwright install-deps

# Install trcli
RUN pip3 install --break-system-packages trcli

# Install global Node/Yarn dependencies
WORKDIR /home/qa/code
RUN yarn install && \
    yarn global add junit-report-merger

# Environment variables
ENV PATH=$PATH:/home/qa/.yarn/bin:/home/qa/.local/bin
ENV QA_PATH=/home/qa/code

# Check versions and system info
RUN date && \
    pwd && \
    ls && \
    docker --version && \
    npm --version && \
    yarn --version && \
    trcli --version && \
    npx playwright -V

# Final cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*