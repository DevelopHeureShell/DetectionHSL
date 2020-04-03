$hslmod = Get-Content $PSScriptRoot\module.json | ConvertFrom-Json
Set-Location $PSScriptRoot 
Set-Location ..
Set-Location ..
$hslroot = Get-Location
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
Remove-Item zipper
Write-Hslcat("info.txt")
Copy-item $hslroot\hsllog.log $pwd
Copy-Item $hslroot\config.json $pwd
if(Test-Path $hslroot\DetectionHSL.zip){
    Remove-item -Force $hslroot\DetectionHSL.zip
}
Compress-Archive  $env:temp\detectionhsl -DestinationPath $hslroot\DetectionHSL.zip
