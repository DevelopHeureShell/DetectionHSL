@echo off 
title DetectionHSL 
cls
::Starts the main module
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./scripts/main/main.ps1"
