

#CCTEHYP0001

$macAddress1 = "MAC-Address_Interface_1"
$macAddress2 = "MAC-Address_Interface_1"

$teamIPAddress = "Team_IP-Address"
$teamGateway = "Team_Gateway"
$teamSubnetLength = "26"
$teamDNSServers = "Team_DNS-Server_1,Team_DNS-Server_2"

$teamName = "Management"

#$vlanID = 3392

$nicAdapter1 = Get-NetAdapter | Where-Object {$_.MacAddress -eq $macAddress1}
$nicAdapter2 = Get-NetAdapter | Where-Object {$_.MacAddress -eq $macAddress2}

New-NetLbfoTeam -Name $teamName -TeamMembers $nicAdapter1.Name,$nicAdapter2.Name -TeamingMode SwitchIndependent -LoadBalancingAlgorithm Dynamic -Confirm:$false
Set-NetLbfoTeamMember -Team $teamName -Name $nicAdapter1.Name -AdministrativeMode Active
Set-NetLbfoTeamMember -Team $teamName -Name $nicAdapter2.Name -AdministrativeMode Active
#Set-NetLbfoTeamNic -Name $teamName -VlanID $vlanID

#New-NetIPAddress -InterfaceAlias "$teamName - VLAN $vlanID" -AddressFamily IPv4 -IPAddress $teamIPAddress -DefaultGateway $teamGateway -PrefixLength $teamSubnetLength
New-NetIPAddress -InterfaceAlias $teamName -AddressFamily IPv4 -IPAddress $teamIPAddress -DefaultGateway $teamGateway -PrefixLength $teamSubnetLength
#Set-DnsClientServerAddress -InterfaceAlias "$teamName - VLAN $vlanID" -ServerAddresses $teamDNSServers
Set-DnsClientServerAddress -InterfaceAlias $teamName -ServerAddresses $teamDNSServers

========================================================================================================================================================================

$macAddress1 = "MAC-Address_Interface_1"
$macAddress2 = "MAC-Address_Interface_2"

$teamIPAddress = "Team_IP-Address"
$teamSubnetLength = "27"
$teamDNSServers = "Team_DNS-Server_1,Team_DNS-Server_2"

$teamName = "Prod"

$nicAdapter1 = Get-NetAdapter | Where-Object {$_.MacAddress -eq $macAddress1}
$nicAdapter2 = Get-NetAdapter | Where-Object {$_.MacAddress -eq $macAddress2}

New-NetLbfoTeam -Name $teamName -TeamMembers $nicAdapter1.Name,$nicAdapter2.Name -TeamingMode SwitchIndependent -LoadBalancingAlgorithm Dynamic -Confirm:$false
Set-NetLbfoTeamMember -Team $teamName -Name $nicAdapter1.Name -AdministrativeMode Active
Set-NetLbfoTeamMember -Team $teamName -Name $nicAdapter2.Name -AdministrativeMode Active

New-NetIPAddress -InterfaceAlias $teamName -AddressFamily IPv4 -IPAddress $teamIPAddress -PrefixLength $teamSubnetLength
Set-DnsClientServerAddress -InterfaceAlias $teamName -ServerAddresses $teamDNSServers

========================================================================================================================================================================

$macAddress1 = "MAC-Address_Interface_1"
$macAddress2 = "MAC-Address_Interface_2"

$teamIPAddress = "Team_IP-Address"
$teamSubnetLength = "23"

$teamName = "MigrationHB"

$nicAdapter1 = Get-NetAdapter | Where-Object {$_.MacAddress -eq $macAddress1}
$nicAdapter2 = Get-NetAdapter | Where-Object {$_.MacAddress -eq $macAddress2}

New-NetLbfoTeam -Name $teamName -TeamMembers $nicAdapter1.Name,$nicAdapter2.Name -TeamingMode SwitchIndependent -LoadBalancingAlgorithm Dynamic -Confirm:$false
Set-NetLbfoTeamMember -Team $teamName -Name $nicAdapter1.Name -AdministrativeMode Active
Set-NetLbfoTeamMember -Team $teamName -Name $nicAdapter2.Name -AdministrativeMode Active

New-NetIPAddress -InterfaceAlias $teamName -AddressFamily IPv4 -IPAddress $teamIPAddress -PrefixLength $teamSubnetLength

========================================================================================================================================================================

Enable-WindowsOptionalFeature -Online -FeatureName MultiPathIO -NoRestart

========================================================================================================================================================================

$hostname = "Hostname"

Rename-Computer -NewName $hostname -Restart

========================================================================================================================================================================

$domain = "Domain"
$credential = "Domain\Username"

Add-Computer -DomainName $domain -Credential $credential -Restart

========================================================================================================================================================================

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" –Value 0
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0)
Invoke-Command -ScriptBlock {NET LOCALGROUP "Remote Desktop Users" /ADD "itdz\ESX-Admin-Gruppe"}

========================================================================================================================================================================

Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

========================================================================================================================================================================

Invoke-Command -ScriptBlock {mpclaim -r -I -d "3PARdataVV"}

========================================================================================================================================================================

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
#Invoke-Command -ScriptBlock {D:\hp\swpackages\hpsum.bat /express_install}
Invoke-Command -ScriptBlock {D:\hp\swpackages\hpsum.bat /s}
