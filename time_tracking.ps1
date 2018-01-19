$File = "<filename>"
$Date = get-date -Format "dd. MM."
$TimeMorning = get-date -date $(get-date).AddMinutes(-5) -Format "HH:mm"
$TimeEvening = get-date -Format "HH:mm"
$Sheet = "Bogen"
$SearchString = "$Date"

$Excel = New-Object -ComObject Excel.Application
$Excel.DisplayAlerts = $false
$Excel.visible = $false
$Workbook = $Excel.Workbooks.open($file)
$Worksheet = $Workbook.Worksheets.Item($Sheet)
$Worksheet.Activate()


$Worksheet.Cells.Item(1,1).Activate()
$Range = $Worksheet.Range("A1").EntireColumn
$Search = $Range.find($SearchString,[Type]::Missing,-4163)
$Search.Activate()
If([string]::IsNullOrEmpty($Worksheet.Cells.Item($Search.Row,"G").value2)) {
    $Worksheet.Cells.Item($Search.Row,"G").Value2 = $TimeMorning
}
$Worksheet.Cells.Item($Search.Row,"H").Value2 = $TimeEvening

$Workbook.Save()
$Workbook.Close()
Start-Sleep 5
$Excel.Quit()

Stop-Process -Processname EXCEL