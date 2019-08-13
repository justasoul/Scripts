# Demora 25 minutos...

$backup_dest_folder = 'C:\NetDados\617857\Backups' # "C:\Bnunes\Backups"

$folder_list = @(  "C:\bnunes\Myserver"
                 , "C:\Bnunes\Backups\Outlook_Archive"
                )

# C:\Bnunes\Backups\Outlook_Archive\archive.pst
# https://stackoverflow.com/questions/47262348/powershell-compress-archive-the-process-cannot-access-the-file-because-it-is-be
# https://stackoverflow.com/questions/14207788/accessing-volume-shadow-copy-vss-snapshots-from-powershell
# https://stackoverflow.com/questions/42998669/unzip-file-using-7z-in-powershell#
# https://www.dotnetperls.com/7-zip-exampless

# set-alias sz "C:\Program Files\7-Zip\7z.exe" -mx3
# 
# sz a "C:\Bnunes\Backups\mail.7z" "C:\Bnunes\Backups\Outlook_Archive"



#########
# UTILS # 
#####################################################################################

function zip {
    param([string] $source_path, [string] $zip_file)

    set-alias sz "C:\Program Files\7-Zip\7z.exe"

    sz a $zip_file $source_path -mx3

}

function close_open_apps {

$outlook = new-object -com Outlook.Application 
$session = $outlook.Session
$outlook.Quit()

}

function get_backup_destination {
  param([string] $source_path)

  $backup_folder = $backup_dest_folder # "C:\Bnunes\Backups"

  $path_leaf = Split-Path $current_folder -Leaf

  $backup_file_path = "$backup_folder\$path_leaf.7z"

  return $backup_file_path
}


########
# MAIN # 
#####################################################################################

Measure-Command {

close_open_apps

for ($i=0; $i -lt $folder_list.length; $i++) {

  $current_folder = $folder_list[$i]

  $backup_file_path = get_backup_destination -source_path $current_folder

  # write-output "$current_folder => $backup_file_path "

  

  # Compress-Archive -Path "C:\bnunes\Myserver" -DestinationPath "C:\Bnunes\Backups\Myserver.zip"
  # Compress-Archive -Path $current_folder  -DestinationPath $backup_file_path -Update
  remove-item      -Path $backup_file_path
  # Compress-Archive -Path $current_folder  -DestinationPath $backup_file_path

  zip -source_path $current_folder -zip_file $backup_file_path

}

}


