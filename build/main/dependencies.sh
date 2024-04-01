#!/bin/bash

# Update package index
apt update

# Set timezone (uncomment if needed)
# echo "surpass-prompt surpass-prompt/geographic-area select Asia" | tee /home/qa/code/.circleci/os/linux/ubuntu/dependencies/surpass-selections
# debconf-set-selections < /home/qa/code/.circleci/os/linux/ubuntu/dependencies/surpass-selections

# # Install dependencies
# echo "Installing dependencies"
# apt install git curl iputils-ping telnet gnupg -y

# # Install Yarn
# echo "Installing Yarn"
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# apt update
# apt install yarn -y

# # Install Node.js
# echo "Installing Node.js"
# apt install nodejs npm -y

# # Install AWS CLI
# echo "Installing AWS CLI"
# apt install python3-pip -y
# pip3 install awscli

# # Install PostgreSQL client
# echo "Installing PostgreSQL client"
# apt install postgresql-client -y

# # Install Java
# echo "Installing Java"
# apt install default-jre default-jdk -y

# # Install Docker and Docker Compose
# echo "Installing Docker and Docker Compose"
# apt-get install -y apt-transport-https ca-certificates software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# apt update
# apt-get install -y docker-ce docker-ce-cli containerd.io
# curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose

# # Node & Yarn dependencies
# echo "Installing Node & Yarn dependencies"
# cd /home/qa/code
# yarn install
# yarn global add junit-report-merger
# export PATH=$PATH:/home/qa/.yarn/bin

# # Install XVFB for browser testing
# echo "Installing XVFB for browser testing"
# apt-get install xvfb -y

# # Install Playwright
# echo "Installing Playwright"
# npx playwright install
# npm install -g trcli
# export PATH=$PATH:/home/qa/.local/bin

# Version check
echo "Version check"
date
pwd
ls
docker --version
docker version
npm --version
yarn --version
trcli --help
aws --version
pip --version
python --version
npm run playwright -v
