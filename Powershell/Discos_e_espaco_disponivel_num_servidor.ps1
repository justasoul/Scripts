$Servidor = 'Ndmwcvallsvc01' # Gestor Eventos / Servicos DEV
            # 'Ndpefvppniis01' # Web DEV    

$discos = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $Servidor -Filter "DriveType=3" | Select-object -ExpandProperty  DeviceID

foreach ($element in $discos) {
	
    $disk = Get-WmiObject Win32_LogicalDisk -ComputerName $Servidor -Filter "DeviceID='$($element)'" |
    Select-Object Size,FreeSpace

    Write-Output "Disco $($element) =>  Total: $([math]::Truncate($disk.Size / 1GB)) Free $([math]::Truncate($disk.FreeSpace/1GB)) Perc: $([math]::Truncate(($disk.FreeSpace/$disk.Size)*100)) % "

}

