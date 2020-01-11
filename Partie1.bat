.\Scripts\Additional_exe\debut_script.exe
.\Scripts\Additional_exe\debut_partie_1.exe
@powershell.exe -noprofile -executionpolicy bypass -file "%~dp0./Scripts/partie1.ps1" -include "%~dp0./Scripts/Core.psm1" -Verb RunAs administartor