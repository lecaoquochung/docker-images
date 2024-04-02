# Use the official Ubuntu base image
FROM ubuntu:noble

# Update package index and install dependencies
RUN apt-get update && \
    apt-get install -y git curl iputils-ping telnet unzip

# Noble not supported packages
# vim

# WORKDIR /home/qa/code
# COPY ./build/$CURRENT_BRANCH/dependencies.sh .
# RUN chmod +x dependencies.sh

# # Verify dependencies
# CMD ["./dependencies.sh"]