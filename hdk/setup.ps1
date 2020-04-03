<#
Setup script pour installer HSL dans un projet 
#>
Write-Output "Ou se trouve le dossier ou copier HSL?"
$dir = Read-Host
if($dir  -eq ""){
    exit
}
Set-Location $PSScriptRoot
Set-Location ..
$files = @(".\config.json",".\README.md", ".\start.bat", ".\main", ".\scripts", ".\.gitignore")
foreach($file in $files){
    Copy-Item -Recurse $file $dir
}
Set-Location $dir
Write-Output "Bon dev!"