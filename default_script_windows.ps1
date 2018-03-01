function setRegKey {
    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
    Set-ItemProperty -Path $regPath -Name EnableAutoTray -Value 0

    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    Set-ItemProperty -Path $regPath -Name AutoCheckSelect -Value 0
    Set-ItemProperty -Path $regPath -Name DisablePreviewDesktop -Value 0
    Set-ItemProperty -Path $regPath -Name DontPrettyPath -Value 0
    Set-ItemProperty -Path $regPath -Name Filter -Value 0
    Set-ItemProperty -Path $regPath -Name Hidden -Value 1
    Set-ItemProperty -Path $regPath -Name HideFileExt -Value 0
    Set-ItemProperty -Path $regPath -Name HideIcons -Value 0
    Set-ItemProperty -Path $regPath -Name IconsOnly -Value 0
    Set-ItemProperty -Path $regPath -Name LaunchTo -Value 1
    Set-ItemProperty -Path $regPath -Name ListviewAlphaSelect -Value 1
    Set-ItemProperty -Path $regPath -Name ListviewShadow -Value 1
    Set-ItemProperty -Path $regPath -Name MapNetDrvBtn -Value 0
    Set-ItemProperty -Path $regPath -Name PersistBrowsers -Value 1
    Set-ItemProperty -Path $regPath -Name ReindexedProfile -Value 1
    Set-ItemProperty -Path $regPath -Name SeparateProcess -Value 0
    Set-ItemProperty -Path $regPath -Name ServerAdminUI -Value 0
    Set-ItemProperty -Path $regPath -Name SharingWizardOn -Value 0
    Set-ItemProperty -Path $regPath -Name ShowCompColor -Value 1
    Set-ItemProperty -Path $regPath -Name ShowEncryptCompressedColor -Value 1
    Set-ItemProperty -Path $regPath -Name ShowInfoTip -Value 1
    Set-ItemProperty -Path $regPath -Name ShowPreviewHandlers -Value 0
    Set-ItemProperty -Path $regPath -Name ShowStatusBar -Value 1
    Set-ItemProperty -Path $regPath -Name ShowSuperHidden -Value 1
    Set-ItemProperty -Path $regPath -Name ShowTypeOverlay -Value 1
    Set-ItemProperty -Path $regPath -Name Start_SearchFiles -Value 2
    Set-ItemProperty -Path $regPath -Name Start_TrackProgs -Value 0
    Set-ItemProperty -Path $regPath -Name StartMenuInit -Value d
    Set-ItemProperty -Path $regPath -Name StoreAppsOnTaskbar -Value 1
    Set-ItemProperty -Path $regPath -Name TaskbarAnimations -Value 1
    Set-ItemProperty -Path $regPath -Name TaskbarGlomLevel -Value 0
    Set-ItemProperty -Path $regPath -Name TaskbarSizeMove -Value 0
    Set-ItemProperty -Path $regPath -Name TaskbarSmallIcons -Value 1
    Set-ItemProperty -Path $regPath -Name TaskbarStateLastRun -Value ([byte[]](0xf7,0x28,0x5e,0x5a,0x00,0x00,0x00,0x00))
    Set-ItemProperty -Path $regPath -Name WebView -Value 1
    Set-ItemProperty -Path $regPath -Name HideMergeConflicts -Value 0

    $regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
    If (-Not(Test-Path $regPath)) {
        New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "People" -Force
    }

    Set-ItemProperty -Path $regPath -Name PeopleBand -Value 0
	
	$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons"
	If (-Not(Test-Path $regPath)) {
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "HideDesktopIcons" -Force
		$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
		If (-Not(Test-Path $regPath)) {
			New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons" -Name "NewStartPanel" -Force
		}
    }
    Set-ItemProperty -Path $regPath -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Value 1
    Set-ItemProperty -Path $regPath -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0

	$regPath = "HKCU:\Console"
	Set-ItemProperty -Path $regPath -Name QuickEdit -Value 1
	Set-ItemProperty -Path $regPath -Name InsertMode -Value 1
}

Set-ExecutionPolicy RemoteSigned
setRegKey

exit