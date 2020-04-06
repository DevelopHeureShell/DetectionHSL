If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs
    Exit
}
Set-Location $env:ProgramFiles
if(Test-path .\DetectionHSL){
    Remove-Item -Recurse -force .\DetectionHSL
}
New-item -ItemType Directory -Name DetectionHSL | Out-Null
Set-Location DetectionHSL
Copy-Item -Recurse $PSScriptRoot\* $pwd
if(Test-Path .\Shortcuts){Remove-item -recurse .\Shortcuts}
$programdir = Get-Location 
Set-Location "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
if(Test-Path .\DetectionHSL){Remove-item -Recurse DetectionHSL}
New-Item -ItemType Directory -Name  DetectionHSL 
Set-location DetectionHSL 
$shortcutdir = Get-Location 
& $programdir\setupshortcuts.ps1 
Copy-Item -recurse $programdir\Shortcuts\*  $shortcutdir
pause