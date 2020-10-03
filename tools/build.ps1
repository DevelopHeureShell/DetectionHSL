#!/usr/bin/env pwsh
Write-Host -ForegroundColor Yellow "Building DetectioHSL...";
Write-Host -ForegroundColor Blue "Checking Deps...";
if(!(Test-path "$HOME/.cargo")) {
    Write-Host -ForegroundColor Red "Oops! Cargo is not installed!";
    exit 1;
}