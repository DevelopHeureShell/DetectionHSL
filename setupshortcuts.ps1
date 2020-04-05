
#Shell pour les raccourcis
$shell = New-Object -comObject WScript.Shell
#Ce script crée des raccourcis pour DetectionHSL
Set-Location $PSScriptRoot 
if(Test-Path .\Shortcuts){Remove-item -recurse Shortcuts}
New-item -ItemType Directory -Name Shortcuts | Out-Null
Set-Location Shortcuts
$starter = $shell.CreateShortcut("${psscriptroot}\Shortcuts\start_hsl.lnk")
$starter.TargetPath = ("$env:windir\system32\cmd.exe")
$starter.Arguments = ("/c ${psscriptroot}\start.bat")
$starter.save() 
#
$updater = $shell.CreateShortcut("${psscriptroot}\Shortcuts\Start-HSLupdate.lnk")
$updater.TargetPath = ("${env:windir}\system32\cmd.exe")
$updater.Arguments = ("/c  ${psscriptroot}\update.bat")
$updater.save()
Write-Output "Ok!"