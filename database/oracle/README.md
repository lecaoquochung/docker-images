
### Build and Run the Docker Image:
1. **Build the Docker image:**
```bash
docker build -t oracle-db .
```

2. **Run the Docker container:**
```bash
docker run -d -p 1521:1521 -p 5500:5500 --name oracle-db oracle-db
```

Notes:
Replace the response files (db_install.rsp, netca.rsp, dbca.rsp) with your custom configurations.
Ensure you have the Oracle installation files (LINUX.X64_193000_db_home.zip) in the same directory as the Dockerfile.
Customize the ports and other environment variables as needed.

Supporting Files:
1. db_install.rsp (response file for Oracle installation)
- Modify this file to match your Oracle Database configuration. Refer to Oracle's documentation for the correct parameters.

2. netca.rsp (response file for Oracle Net Configuration Assistant)
- Configure your listener settings here.

3. dbca.rsp (response file for Oracle Database Configuration Assistant)
- Customize it for your database name, SID, password, and other settings.

4. setupDatabase.sh

5. startDB.sh