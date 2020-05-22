Set-location $PSScriptRoot 
sfc /scannow 
dism /online /cleanup-image /scanhealth 
pause 
pause