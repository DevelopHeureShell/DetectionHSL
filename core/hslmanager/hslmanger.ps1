#!/usr/bin/env pwsh
$config = Get-content $PSScriptRoot\..\..\config.json | ConverFrom-Json
Write-Host "HSLManager ${config.version.type} V${config.version.major.toStringt()}.${config.version.minor.toString()}.${config.version.patch} "
