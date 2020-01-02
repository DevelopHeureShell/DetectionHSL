write-output Début des réparations...
Sfc /scannow 
sfc terminé 
net stop wuauserv
net start wuauserv
timeout /t 12
Dism /online /cleanup-image /restorehealth
#chkdsk /f
start-sleep