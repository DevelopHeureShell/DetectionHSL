If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Host "Relancement du script en admin"
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs
    exit
}
$host.ui.RawUI.WindowTitle = "DetectionHSL"
Set-Location $PSScriptRoot\..\..\main 
$maindir = Get-Location
function Write-hslcat {
    param(
        [string]$File = $null 
    )
    if (!(Test-Path $PSScriptRoot\$File)) { return }
    & $maindir\cat.exe $PSScriptRoot\$File
}
