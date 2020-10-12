#!/usr/bin/env pwsh
$BASELOC = Get-Location
Import-Module "${PSScriptRoot}\lib\libbuild.psm1"
Write-Host -ForegroundColor Yellow "Building DetectioHSL...";
Write-Host -ForegroundColor Blue "Checking Deps...";
if(!(Test-path "$HOME/.cargo")) {
    Write-Host -ForegroundColor Red "Oops! Cargo is not installed!";
    exit 1;
}
Write-Host -ForegroundColor Green "Dependencies OK!";
$packs = @(
    "hsl10n",
    "hslconfig"
)
foreach($pack in $packs) {
    Invoke-CargoPackageBuild -Name $pack
}
Write-Host -ForegroundColor Green "Done!";
Set-Location $PSScriptRoot;
Set-Location $BASELOC.Path