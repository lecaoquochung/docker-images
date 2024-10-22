#!/bin/bash
echo "Starting Oracle Listener..."
lsnrctl start

echo "Starting Oracle Database..."
sqlplus / as sysdba <<EOF
startup;
exit;
