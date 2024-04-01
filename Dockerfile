# Use the official Ubuntu base image
FROM ubuntu:23.10

# Update package index and install dependencies
RUN apt-get update && \
    apt-get install -y git curl iputils-ping telnet vim unzip

# Ubuntu noble 24.04
# 
# gnupg stands for GNU Privacy Guard, which is a free and open-source 
# implementation of the OpenPGP (Pretty Good Privacy) standard. 
# It provides cryptographic privacy and authentication for data communication. 
# gnupg is commonly used for encrypting and decrypting files, 
# signing and verifying messages, and managing cryptographic keys.
# gnupg : Depends: dirmngr (< 2.4.4-2ubuntu15.1~) 
# Resolve this dependency issue by installing dirmngr alongside gnupg. 
# Here's the command:
#  Unable to correct problems, you have held broken packages.
# RUN apt-get update && \
#     apt-get install -y --fix-broken gnupg dirmngr

RUN apt-get update && \
    apt-get install -y gnupg dirmngr
    
# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn

# Install Node.js
RUN apt-get install -y nodejs npm 

# Install Python3 and virtual environment
RUN apt-get update && \
    apt-get install -y python3 python3-venv python3-pip

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Install PostgreSQL client
RUN apt-get install -y postgresql-client 

# Install Java
RUN apt-get install -y default-jre default-jdk
   
# Install Docker
RUN apt-get install -y apt-transport-https ca-certificates software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Install XVFB for browser testing
RUN apt-get install -y xvfb

# Install Playwright
RUN npm install -g playwright && \
    npx playwright install
    # npx playwright install-deps 

# Install Testrail
# RUN pip3 install trcli
# RUN pip install trcli

# Set PATH environment variable
ENV PATH="/home/qa/.yarn/bin:${PATH}:/home/qa/.local/bin"

# Set default value for CURRENT_BRANCH argument
ARG CURRENT_BRANCH=main
# Use the build argument to set the environment variable
ENV CURRENT_BRANCH=$CURRENT_BRANCH
# Set the directory path with the current branch name
ENV DIRECTORY_PATH="/home/$CURRENT_BRANCH/code"

WORKDIR /home/qa/code
COPY ./build/$CURRENT_BRANCH/dependencies.sh .
RUN chmod +x dependencies.sh

# Insstall dependencies
CMD ["./dependencies.sh"]