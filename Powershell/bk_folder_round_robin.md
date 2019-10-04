
````powershell
$date_sufix       = get-date -uformat "%Y%m%d_%H%M%S" 
$origin_path      = "C:\bnunes"
$destination_path = $PSScriptRoot + "\bnunes__" + $date_sufix + ".zip"

# Comprimir o ficheiro e guardar em $destination_path
Compress-Archive -Path $origin_path -CompressionLevel optimal -DestinationPath $destination_path

# Manter apenas os últimos 5 ficheiros ZIP de backup
Get-ChildItem $PSScriptRoot -Recurse| where{-not $_.PsIsContainer -and $_.Extension -eq ".zip"}| sort CreationTime -desc| 
    select -Skip 5| Remove-Item -Force
````
