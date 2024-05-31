# Verify official dependencies
# https://hub.docker.com/r/jenkins/jenkins
pwd;whoami;ls;
uname -a
cat /etc/os-release
cat /etc/*-release

# Jenkins default
java --version
ls -all /usr/lib
ls -all /var/jenkins_home

# Create the missing directory and set permissions
mkdir -p /var/lib/apt/lists/partial && \
  chown -R _apt:root /var/lib/apt/lists && \
  chmod -R 755 /var/lib/apt/lists

# Update package lists and install required packages
apt-get update && \
  apt-get install -y git curl iputils-ping telnet vim unzip

# Install mysql-client
apt-get install -y default-mysql-client