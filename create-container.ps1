param (
  # the port to run the container on, defaults to 1433
  [int] $port = 1433,
  
  # the name of the new container, defaults to fadb
  [string] $name = "fadb",

  # the sa account password, defaults to H3lloWorld!
  [string] $password = "H3lloWorld!"
)

# run the docker container
$portStr = "${port}:${port}"
$(docker run -d -p $portStr --name $name --restart unless-stopped -e sa_password=$password -e ACCEPT_EULA=Y microsoft/mssql-server-windows-express)

# wait for the container to exist
$inspectStr = "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"
$containerIP = $(docker inspect -f $inspectStr $name)
echo "the container is running and has IP address $containerIP"

# wait for the SQL service to run
echo "Waiting for the SQL server to start"
$logs = ""
while ( ([string]::IsNullOrEmpty($logs)) -Or (! $logs.ToLower() -contains "started") ) {
  $logs = $(docker logs $name)
  if ( ([string]::IsNullOrEmpty($logs)) -Or (! $logs.ToLower() -contains "started") ) {
    # sleep for a second while waiting for the sql service to start
    Start-Sleep -Seconds 1
  }
}
echo "SQL Server is up and running"

# get the current working directory path
$path = Split-Path -Parent $PSCommandPath
$scriptPath = $path + "\db.sql"

$success = false
#while ( !$success ) {
  try {
    # run the script on the container
    $result = $(Invoke-Sqlcmd -ServerInstance $containerIP -Username sa -Password $password -InputFile $scriptPath)
    $success = true
  }
  catch {
    echo $_
    # sleep for a second then try again
    #Start-Sleep -Seconds 1
  }
#}

echo $result

echo "Finished creating the '$name' container with IP Address $containerIP"
