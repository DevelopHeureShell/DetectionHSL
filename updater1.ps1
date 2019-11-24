Set-ExecutionPolicy Bypass
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
refreshenv
choco install git -y
cd $psscriptroot
refreshenv
git clone https://github.com/Woomy4680-exe/DetectionHSL.git 
pause
