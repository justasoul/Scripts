# VER: https://gist.github.com/jfromaniello/1125265
# VER: https://stackoverflow.com/questions/7523497/should-copy-item-create-the-destination-directory-structure/7523632
# watch a file changes in the current directory, 
# execute all tests when a file is changed or renamed

#  
#  
#  
#  ToDo: Nâo está a funcionar bem quando se faz um MOVE (apenas interpreta 
#        como um delete do folder original)
#  
#  
#  

function current_dthr_sufix {

  $(get-date).toString("yyyyMMdd__HHMMss__fff")
}

function del_sufix {

  "__DEL_" +  (current_dthr_sufix) 

}

function exclude_folders {
Param (
[string]$p_path
) 

    $lb_res = $false;

    if (    # $p_path -like "*PortableAppsPlatform*" `
            $p_path.ToUpper() -like "*PortableAppsPlatform*".ToUpper() `
        -or $p_path -like "*PetProjects*" `
        -or $p_path -like "Backups*" `
       ) {
       $lb_res = $true

    } else {
    
       $lb_res = $false

    }
    
    $lb_res
     
}

# $BackupFolder  = "C:\bnunes\temp\20180416\"
# $WatchedFolder = "C:\Bnunes\" 

$WatchedFolder = "C:\Bnunes\Toolkit\Scripts\Python\" 
$BackupFolder  = "C:\Bnunes\Temp\20180416\"



$watcher                       = New-Object System.IO.FileSystemWatcher
$watcher.Path                  = $WatchedFolder # get-location
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents   = $true
$watcher.NotifyFilter          = [System.IO.NotifyFilters]::LastWrite `
                            -bor [System.IO.NotifyFilters]::FileName `
                            -bor [System.IO.NotifyFilters]::DirectoryName 

while($TRUE){

	$result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Changed `
                                 -bor [System.IO.WatcherChangeTypes]::Renamed `
                                 -bor [System.IO.WatcherChangeTypes]::Created `                                 -bor [System.IO.WatcherChangeTypes]::Deleted `                                  , 1000 `
                                 );
	if($result.TimedOut){
		continue;
	}

    if ( -not (exclude_folders($result.Name) ) ) {

	    $FromFile            = $watcher.Path + $result.Name
	    $ToFile              = $BackupFolder + $result.Name
        $FromFileisDirectory = Test-Path -Path $FromFile -PathType Container
        $ToFileisDirectory   = Test-Path -Path $ToFile -PathType Container
	
	
        Write-Host "######################################################### "
        Write-Host "# ChangeType:          " + $result.ChangeType
        Write-Host "# FromFile:            " + $FromFile
        Write-Host "# ToFile:              " + $ToFile
        Write-Host "# FromFileisDirectory: " + $FromFileisDirectory
        Write-Host "######################################################### "
    

        if ($result.ChangeType -eq [System.IO.WatcherChangeTypes]::Deleted) {
            #
            # DELETE 
            #

            if ($ToFileisDirectory) {

                Rename-Item -Path $ToFile -NewName ($ToFile + (del_sufix) )  
            
            } else {
            
                $ToFile = $ToFile + (del_sufix)

                New-Item -ItemType File -Path $ToFile -Force

            }

        }
        else {
            # 
            # CREATE / UPDATE
            #

            if ( $FromFileisDirectory) {
                New-Item -ItemType Directory -Path $ToFile -Force
            } else {
                $ToFile = $ToFile + "__" + (current_dthr_sufix)

		        New-Item -ItemType File -Path $ToFile -Force
                Copy-Item  $FromFile -Destination $ToFile -Recurse -Force     
                    
            }

		        

	    }

    } 

}