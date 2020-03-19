


# SQL Server

docker run -it mcr.microsoft.com/mssql-tools

usage: sqlcmd [-U login id] [-P password] [-S server or Dsn if -D is provided] [-H hostname] [-E trusted connection] [-N Encrypt Connection][-C Trust Server Certificate] [-d use database name] [-l login timeout] [-t query timeout] [-h headers] [-s colseparator] [-w screen width] [-a packetsize] [-e echo input] [-I Enable Quoted Identifiers] [-c cmdend] [-q "cmdline query"] [-Q "cmdline query" and exit] [-m errorlevel] [-V severitylevel] [-W remove trailing spaces] [-u unicode output] [-r[0|1] msgs to stderr] [-i inputfile] [-o outputfile] [-k[1|2] remove[replace] control characters] [-y variable length type display width] [-Y fixed length type display width] [-p[1] print statistics[colon format]] [-R use client regional setting] [-K application intent] [-M multisubnet failover] [-b On error batch abort] [-D Dsn flag, indicate -S is Dsn] [-X[1] disable commands, startup script, environment variables [and exit]] [-x disable variable substitution] [-? show syntax summary]

Example: # sqlcmd -S 127.0.0.1 -U sa -P MyPassword100 > select @@version > go

### Query Sql Server

```bash
docker-compose -f docker-compose.db.yml up
docker exec -it <--db_service_id--> bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Str0ngPassW0rd!'

> SELECT Name from sys.Databases
> GO

> USE SprocTest
> GO

> SELECT * from Incrementor
> GO

```
