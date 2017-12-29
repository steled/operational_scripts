$ISEprofile = $profile -replace "Microsoft.PowerShell_profile.ps1", "Microsoft.PowerShellISE_profile.ps1"

function setRegKey {
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    Set-ItemProperty -Path $regPath -Name Start_SearchFiles -Value 1
    Set-ItemProperty -Path $regPath -Name StoreAppsOnTaskbar -Value 1
    Set-ItemProperty -Path $regPath -Name StartMenuAdminTools -Value 1
    Set-ItemProperty -Path $regPath -Name ServerAdminUI -Value 0
    Set-ItemProperty -Path $regPath -Name Hidden -Value 1
    Set-ItemProperty -Path $regPath -Name ShowCompColor -Value 1
    Set-ItemProperty -Path $regPath -Name HideFileExt -Value 0
    Set-ItemProperty -Path $regPath -Name DontPrettyPath -Value 0
    Set-ItemProperty -Path $regPath -Name ShowInfoTip -Value 1
    Set-ItemProperty -Path $regPath -Name HideIcons -Value 0
    Set-ItemProperty -Path $regPath -Name MapNetDrvBtn -Value 0
    Set-ItemProperty -Path $regPath -Name WebView -Value 1
    Set-ItemProperty -Path $regPath -Name Filter -Value 0
    Set-ItemProperty -Path $regPath -Name ShowSuperHidden -Value 1
    Set-ItemProperty -Path $regPath -Name SeparateProcess -Value 0
    Set-ItemProperty -Path $regPath -Name AutoCheckSelect -Value 0
    Set-ItemProperty -Path $regPath -Name IconsOnly -Value 0
    Set-ItemProperty -Path $regPath -Name ShowTypeOverlay -Value 1
    Set-ItemProperty -Path $regPath -Name ShowStatusBar -Value 1
    Set-ItemProperty -Path $regPath -Name StartMenuInit -Value 6
    Set-ItemProperty -Path $regPath -Name TaskbarSizeMove -Value 0
    Set-ItemProperty -Path $regPath -Name DisablePreviewDesktop -Value 1
    Set-ItemProperty -Path $regPath -Name TaskbarSmallIcons -Value 1
    Set-ItemProperty -Path $regPath -Name TaskbarGlomLevel -Value 0
    Set-ItemProperty -Path $regPath -Name HideMergeConflicts -Value 0
    Set-ItemProperty -Path $regPath -Name PersistBrowsers -Value 1
    Set-ItemProperty -Path $regPath -Name SharingWizardOn -Value 0
	
	$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons"
	If (-Not(Test-Path $regPath)) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "HideDesktopIcons" -Force
		$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
		If (-Not(Test-Path $regPath)) {
			New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons" -Name "NewStartPanel" -Force
		}
	}
	Set-ItemProperty -Path $regPath -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0
	$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
	Set-ItemProperty -Path $regPath -Name EnableAutoTray -Value 0
	$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
	Set-ItemProperty -Path $regPath -Name TaskbarSmallIcons -Value 1
	
	$regPath = "HKCU:\Console"
	Set-ItemProperty -Path $regPath -Name QuickEdit -Value 1
	Set-ItemProperty -Path $regPath -Name InsertMode -Value 1
}

if(!(Test-Path Y:)) {
    net use y: \\10.116.8.66\ablage$
}

if(!(Test-Path $ISEprofile)) {
    New-Item -Path $ISEprofile -ItemType File -Force
    ". `"C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1`"" >> $ISEprofile
    setRegKey
}

PowerShell_ISE

exit
