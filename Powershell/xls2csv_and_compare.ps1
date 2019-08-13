Clear-Host

$Working_dir = $PSScriptRoot

$XLS_OLD_PATH = "$($Working_dir)\ExportExcel__OLD.xls"
$CSV_OLD_PATH = "$($Working_dir)\ExportExcel__OLD.csv"

$XLS_NEW_PATH = "$($Working_dir)\ExportExcel__NEW.xls"
$CSV_NEW_PATH = "$($Working_dir)\ExportExcel__NEW.csv"


# Remove if exists 
If (Test-Path   $CSV_OLD_PATH){
	Remove-Item $CSV_OLD_PATH
}

If (Test-Path   $CSV_NEW_PATH){
	Remove-Item $CSV_NEW_PATH
}


# OLD - Convert to csv
$ExcelWB = new-object -comobject excel.application
$Workbook = $ExcelWB.Workbooks.Open($XLS_OLD_PATH) 
$Workbook.SaveAs($CSV_OLD_PATH,6)
$Workbook.Close($false)
$ExcelWB.quit()

# NEW - Convert to csv
$ExcelWB = new-object -comobject excel.application
$Workbook = $ExcelWB.Workbooks.Open($XLS_NEW_PATH) 
$Workbook.SaveAs($CSV_NEW_PATH,6)
$Workbook.Close($false)
$ExcelWB.quit()


# Compare CSV's
Compare-Object -referenceobject  $(get-content $CSV_OLD_PATH) `
               -differenceobject $(get-content $CSV_NEW_PATH)