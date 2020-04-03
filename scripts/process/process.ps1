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
Write-Hslcat("info.txt")
Set-Location $env:TEMP\detectionhsl\process
Get-Process | Format-List -Property ProcessName >> process.txt 
Get-WmiObject -Class Win32_Product | Format-List -Property Name, Vendor, Version >> apps.txt
Get-AppPackage | Format-List -Property Name, Architecture, Version >> appstore.txt
Get-Service >> Services.txt