#!/usr/bin/env pwsh
Write-Host -ForegroundColor Yellow "Building DetectioHSL...";
Write-Host -ForegroundColor Blue "Checking Deps...";
if(!(Test-path "$HOME/.cargo")) {
    Write-Host -ForegroundColor Red "Oops! Cargo is not installed!";
    exit 1;
}
Write-Host -ForegroundColor Green "Dependencies OK!";
Set-Location "${PSScriptRoot}\..";
$ROOT = Get-Location;
Write-Host -ForegroundColor Yellow "Building HSL10N";
Set-Location "${ROOT}/core/hsl10n";
cargo build --release; 
Remove-Item "${PWD}/target/release/hsl10n.d";
New-Item -ItemType Directory -Path "${ROOT}/bin"
Copy-Item "${PWD}/target/release/hsl10n*" "${ROOT}/bin/";
Write-Host -ForegroundColor Green "Done!";
Set-Location $PSScriptRoot;