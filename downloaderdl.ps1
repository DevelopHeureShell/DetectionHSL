Set-location $PSScriptRoot
Invoke-WebRequest -OutFile .\downloader.ps1 https://raw.githubusercontent.com/Woomy4680-exe/DetectionHSL/master/downloader.ps1
Start-Process powershell.exe -ArgumentList "-File $psscriptroot\downloader.ps1"