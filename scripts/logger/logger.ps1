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
Set-Location $env:TEMP\detectionhsl\logger\
Write-Hslcat("info.txt")
#evtlog
Get-EventLog -logname system | Format-List -Property Source, EntryType, Message >> evtlog.txt
#LOG d'update
Get-Windowsupdatelog -LogPath .\wulog.txt