$hslmod = Get-Content $PSScriptRoot\module.json | ConvertFrom-Json
Set-Location $PSScriptRoot 
Set-Location ..
Set-Location ..
Set-Location .\main
$host.ui.RawUI.WindowTitle = $hslmod.name + " version " + $hslmod.version + " par " + $hslmod.author
$maindir = Get-Location
function Write-Hslcat {
    param(
        [string]$file = ""
    )
    if ($file -eq "") { break }
    & $maindir\cat.exe $PSScriptRoot\$file

}
Set-Location $env:TEMP\detectionhsl\
if(!(Test-Path .\sysverify)){
    exit
}
Set-Location sysverify
$sfhash = Get-FileHash sfc.txt -Algorithm SHA256
$dishash = Get-FileHash dism.txt -Algorithm SHA256
$sfhash = $sfhash.hash 
$dishash = $dishash.hash
if (!($sfhash -eq "F6FFC9C15D8EE18FE90C7F26A72FE2BFC54D9706EE94A40A65F9234594000335")){
    Write-Hslcat("sfstart.txt")
    sfc /scannow 
}
if (!($dishash -eq "C285F7F56CDD9CAAC7AF2902C81D74B53D10175A47F3F178A39CB6B989A7E8B1")){
    Write-Hslcat("dismstart.txt")
    dism /online /cleanup-image /restorehealth
}