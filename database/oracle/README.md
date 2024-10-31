# Oracle Database Docker Setup Guide  

## Build and Run the Docker Image
1. **Build the Docker image:**
```bash
docker build -t oracle-db .
```

2. **Run the Docker container:**
```bash
docker run -d -p 1521:1521 -p 5500:5500 --name oracle-db oracle-db

docker run -d \  
    -p 1521:1521 `# Oracle listener port` \  
    -p 5500:5500 `# Enterprise Manager Express port` \  
    -v oracle_data:/opt/oracle/oradata `# Persist database files` \  
    --name oracle-db \  
    oracle-db  
  
# Verify container is running and healthy  
docker logs -f oracle-db 
```

Notes:
Replace the response files (db_install.rsp, netca.rsp, dbca.rsp) with your custom configurations.
Ensure you have the Oracle installation files (LINUX.X64_193000_db_home.zip) in the same directory as the Dockerfile.
Customize the ports and other environment variables as needed.

Prerequisites:  
1. Oracle Database installation files:  
   - Download LINUX.X64_193000_db_home.zip from Oracle website (requires Oracle account)  
   - Place it in the `database/oracle` directory  

2. Response files (in `database/oracle/response`):  
   - db_install.rsp: Oracle installation configuration  
   - netca.rsp: Network configuration  
   - dbca.rsp: Database creation parameters  

3. License Requirements:  
   - Ensure compliance with Oracle Database licensing terms  
   - Review Oracle's container licensing policies  

4. System Requirements:  
   - Minimum 4GB RAM  
   - 20GB free disk space  

## Supporting Files  

### Response Files  

1. `db_install.rsp`: Oracle installation configuration  
   - Defines installation parameters like Oracle home, base  
   - Sets installation type and components  
   - Reference: [Oracle Installation Parameters](link-to-docs)  

2. `netca.rsp`: Network Configuration  
   - Configures Oracle Net listener on port 1521  
   - Sets listener name and protocol settings  

3. `dbca.rsp`: Database Configuration  
   - Sets database name, SID, and credentials  
   - Configures memory, character set, and storage  

### Automation Scripts  

1. `setupDatabase.sh`: Database Creation Script  
   - Runs Oracle DBCA in silent mode  
   - Creates the database using dbca.rsp parameters  
   - Usage: Automatically executed during container build  

2. `startDB.sh`: Database Startup Script  
   - Starts Oracle Net Listener  
   - Starts Oracle Database instance  
   - Verifies database availability  
   - Usage: Container entrypoint script  
