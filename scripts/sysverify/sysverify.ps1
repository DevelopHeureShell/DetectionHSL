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
Write-Hslcat("sfstart.txt")
Set-Location $env:TEMP
Set-Location detectionhsl
Set-Location $hslmod.name
$hslenco = [console]::OutputEncoding
[console]::OutputEncoding = [Text.Encoding]::Unicode
sfc /verifyonly >> sfc.txt
$cleanup = Get-Content sfc.txt | Select-String windows
Set-Content sfc.txt $cleanup
[console]::OutputEncoding = $hslenco
#Passage au DISM
Write-Hslcat("dismstart.txt")
dism /online /cleanup-image /scanhealth >> dism.txt 
$propre = Get-Content dism.txt | Select-string composants
Set-content dism.txt $propre
