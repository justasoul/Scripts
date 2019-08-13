# Precisa de correr na versão 32bit do powershell / ISE 
#     C:\Windows\SysWOW64\WindowsPowerShell\v1.0
# Ver: 
#   http://www.madwithpowershell.com/2015/06/64-bit-vs-32-bit-powershell.html
#   https://tiredblogger.wordpress.com/2009/09/01/querying-oracle-using-powershell/

param (
    [string]$server = "nome do servidor",
    [string]$instance = "SID DA BD", # $(throw "a database name is required"),
    [string]$port     = '####',
    [string]$query = "Select * from dual ",
    [string]$schema = "schema_name",
    [string]$password = "schema_password" 
)

[System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient") | out-null
$connection = new-object system.data.oracleclient.oracleconnection( `
    "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$server)(PORT=$port)) `
    (CONNECT_DATA=(SERVICE_NAME=$instance)));User Id=$schema;Password=$password;");

$set = new-object system.data.dataset    

$adapter = new-object system.data.oracleclient.oracledataadapter ($query, $connection)
$adapter.Fill($set)

$table = new-object system.data.datatable
$table = $set.Tables[0]

#return table

#$table | Export-Csv C:\bnunes\export_powershell.csv -Delimiter ";" -notype # ver como CSV
# $table | Out-GridView # ver em grid 
$table | ConvertTo-Html > C:\bnunes\export_powershell.html # Converter para HTML

