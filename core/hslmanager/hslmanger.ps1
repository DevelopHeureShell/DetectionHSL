#!/usr/bin/env pwsh
## Import LANG module
Import-Module "${PSScriptRoot}/../lib/lang.psm1"
$config = Get-content "${PSScriptRoot}\..\..\config.json" | ConvertFrom-Json
$bootstr = "HSLManager {0} V {1}.{2}.{3}" -f $config.version.type, $config.version.major, $config.version.minor, $config.version.patch
Write-Host $bootstr
if(!$args[0]) {
    Get-LangMessage -modname "manager" -msg "invalmod" -lang "fr"
}