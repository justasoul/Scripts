
$curr_path = (Get-Item -Path ".\").FullName
$curr_date = $(Get-Date).toString("yyyyMMdd__HHmmss")
$dest_path = "$($curr_path)\BK\$($curr_date)"




$exclude_list = "BK" 


write-output "ORIG: $($curr_path)"
Write-Output "DEST: $($dest_path)"

Get-ChildItem -Path $curr_path -Exclude $exclude_list | Copy-Item -Destination $dest_path  -Recurse -Container

