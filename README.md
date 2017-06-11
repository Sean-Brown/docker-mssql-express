# docker-mssql-express
An example of strange behavior when running Invoke-Sqlcmd against a newly created MSSQL Express container in a powershell script.

The powershell script is pretty basic:  
  1. it spins up a new [Microsoft SQL Server Express](https://hub.docker.com/r/microsoft/mssql-server-windows-express/) container
  2. obtains the new container's IP address
  3. waits for the SQL service to be running in the container
  4. runs a database setup SQL script via the [Invoke-Sqlcmd](https://docs.microsoft.com/en-us/sql/powershell/invoke-sqlcmd-cmdlet) powershell commandlet

The strangeness I've observed is that the script _usually_ fails (it sometimes does succeed) when it runs the Invoke-Sqlcmd command, but if I run the command manually it succeeds.
