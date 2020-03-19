#!/bin/bash
wait_time=35s

echo creating resources in $wait_time
sleep $wait_time
echo starting...

set -Ee

trap "Error on line $LINENO" ERR

echo 'Creating User and DB'
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./init.sql

echo 'Creating Tables'
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./data/CreateTables.sql

echo 'Create Stored Proc'
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i ./data/CreateStoredProc.sql

echo 'Importing data...'
/opt/mssql-tools/bin/bcp Incrementor in data/IncrementorData.csv -S 0.0.0.0 -U sa -P $SA_PASSWORD -d SprocTest -F2 -c -t ','

echo 'Completed importing data...'
