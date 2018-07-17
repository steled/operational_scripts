# For normal PowerShell-CLI add the following lines to:
#   C:\Users\<USERNAME>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# For PowerShell-ISE add the following lines to:
#   C:\Users\stephan.leddin\Documents\WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1
function Connect-***-Vcenter {
    $vcenter = "vCenter"
    if (!(Get-Module -Name VMware.PowerCLI))
    {
        Import-Module VMware.PowerCLI
    }
    Connect-VIServer $vcenter
}
Set-Alias -Name cev -Value Connect-***-Vcenter -Description "Import VMware.PowerCLI Module and connect to ***-vCenter"