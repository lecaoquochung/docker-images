# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Set environment variables
ENV ORACLE_BASE=/opt/oracle \
    ORACLE_HOME=/opt/oracle/product/19c/dbhome_1 \
    ORACLE_SID=ORCLCDB \
    PATH=$PATH:/opt/oracle/product/19c/dbhome_1/bin

# Update Ubuntu and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    apt-get install -y --no-install-recommends \
    libaio1 \
    unzip \
    wget \
    zip \
    sudo \
    net-tools \
    bc && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /opt/oracle/product/19c/dbhome_1 && \
    mkdir -p /opt/oracle/oradata && \
    mkdir -p /opt/oracle/scripts/setup && \
    mkdir -p /opt/oracle/scripts/startup

# Add Oracle installation files (assume they are in the current directory)
#ADD LINUX.X64_193000_db_home.zip /opt/oracle/
COPY LINUX.X64_193000_db_home.zip /opt/oracle/  
WORKDIR /opt/oracle

# Install Oracle Database software
RUN unzip LINUX.X64_193000_db_home.zip -d /opt/oracle/product/19c/dbhome_1 && \
    rm LINUX.X64_193000_db_home.zip

# Set up Oracle environment and permissions
RUN groupadd -g 54321 oinstall && \
    groupadd -g 54322 dba && \
    useradd -u 54321 -g oinstall -G dba oracle && \
    chown -R oracle:oinstall /opt/oracle && \
    chmod -R 775 /opt/oracle

# Switch to the oracle user
USER oracle

# Copy necessary response files and scripts for silent installation
COPY db_install.rsp /opt/oracle/
COPY netca.rsp /opt/oracle/
COPY dbca.rsp /opt/oracle/

# Environment variable for silent installation
ENV INSTALL_RSP=/opt/oracle/db_install.rsp \
    NETCA_RSP=/opt/oracle/netca.rsp \
    DBCA_RSP=/opt/oracle/dbca.rsp

# Run Oracle installer in silent mode
RUN /opt/oracle/product/19c/dbhome_1/runInstaller -silent -responseFile /opt/oracle/db_install.rsp -ignorePrereq && \
    exit 

USER root  
RUN /opt/oracle/oraInventory/orainstRoot.sh && \  
    /opt/oracle/product/19c/dbhome_1/root.sh
USER oracle

# Set up listener and create the database
RUN $ORACLE_HOME/bin/netca -silent -responseFile $NETCA_RSP && \
    $ORACLE_HOME/bin/dbca -silent -createDatabase -responseFile $DBCA_RSP

# Expose Oracle Listener and EM Express ports
EXPOSE 1521 5500

# Add startup scripts
# COPY setupDatabase.sh /opt/oracle/scripts/setup/
# COPY startDB.sh /opt/oracle/scripts/startup/
# RUN chmod +x /opt/oracle/scripts/setup/setupDatabase.sh /opt/oracle/scripts/startup/startDB.sh
USER root  
COPY setupDatabase.sh /opt/oracle/scripts/setup/  
COPY startDB.sh /opt/oracle/scripts/startup/  
RUN chmod +x /opt/oracle/scripts/setup/setupDatabase.sh /opt/oracle/scripts/startup/startDB.sh  
USER oracle

# Set the entry point to start the database
ENTRYPOINT ["/opt/oracle/scripts/startup/startDB.sh"]
