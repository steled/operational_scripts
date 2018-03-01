Set-Location <folder>
Get-Item ./* | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-30)} | Get-Acl | Select-Object @{Label="Path"; Expression={$_.Path.Substring(38)}}, Owner
$folder = Get-Item ./* | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-30)} | Get-Acl | Select-Object @{Label="Path"; Expression={$_.Path.Substring(38)}}, @{Label="Owner"; Expression={$_.Owner.Substring(5)}}
foreach($f in $folder) {
    $email = Get-ADUser $f.Owner -Properties EmailAddress | Select-Object EmailAddress
    Send-MailMessage -To $email.EmailAddress -From <e-mail_address> -Subject $f.Path
}