#!/bin/bash
echo "Setting up the Oracle Database..."
$ORACLE_HOME/bin/dbca -silent -createDatabase -responseFile /opt/oracle/dbca.rsp
