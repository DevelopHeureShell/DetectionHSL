#!/usr/bin/env pwsh
$config = Get-content $PSScriptRoot\..\..\config.json | ConvertFrom-Json
$bootstr = "HSLManager {0} V {1}.{2}.{3}" -f $config.version.type, $config.version.major, $config.version.minor, $config.version.patch
Write-Host $bootstr
if(!$args[0]) {
    Write-host -foregroundColor Red "Merci de spécifier la module à utiliser!";
}
