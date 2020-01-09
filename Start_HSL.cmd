@echo off 
::partie1
"%~dp0.\Scripts\Additional_exe\debut_script.exe"
"%~dp0.\Scripts\Additional_exe\debut_partie_1.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie1.ps1" -include "%~dp0./Scripts/Core.psm1" 
::partie2
"%~dp0.\Scripts\Additional_exe\debut_partie_2.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie2.ps1" -include "%~dp0./Scripts/Core.psm1" 
::partie3
"%~dp0.\Scripts\Additional_exe\debut_partie_3.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie3.ps1" -include "%~dp0./Scripts/Core.psm1"  
::partie4
"%~dp0.\Scripts\Additional_exe\debut_partie_4.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie4.ps1" -include "%~dp0./Scripts/Core.psm1" 
::partie5
"%~dp0.\Scripts\Additional_exe\debut_partie_5.exe"
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie5.ps1" -include "%~dp0./Scripts/Core.psm1"