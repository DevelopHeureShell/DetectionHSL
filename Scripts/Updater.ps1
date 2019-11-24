Set-ExecutionPolicy Bypass
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
refreshenv
choco install git -y
cd $psscriptroot
refreshenv
.\Updater1.ps1
pause
