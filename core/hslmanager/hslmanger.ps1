#!/usr/bin/env pwsh
$config = Get-content $PSScriptRoot\..\..\config.json | ConvertFrom-Json
Write-Host "HSLManager " $config.version.type $config.version.major"."$config.version.minor"."$config.version.patch
if(!$args[0]) {
    Write-host -foregroundColor Red "Merci de spécifier la module à utiliser!";
}
