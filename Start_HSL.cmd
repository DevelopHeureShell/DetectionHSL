@echo off 
::partie1
"%~dp0Scripts\Additional_exe\debscript.exe"
"%~dp0Scripts\Additional_exe\deb1.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie1.ps1" -include "%~dp0./Scripts/Core.psm1" 
::partie2
"%~dp0Scripts\Additional_exe\deb2.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie2.ps1" -include "%~dp0./Scripts/Core.psm1" 
::partie3
"%~dp0Scripts\Additional_exe\deb3.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie3.ps1" -include "%~dp0./Scripts/Core.psm1"  
::partie4
"%~dp0Scripts\Additional_exe\deb4.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie4.ps1" -include "%~dp0./Scripts/Core.psm1" 
::partie5
"%~dp0Scripts\Additional_exe\deb5.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie5.ps1" -include "%~dp0./Scripts/Core.psm1"
"%~dp0Scripts\Additional_exe\end.exe"