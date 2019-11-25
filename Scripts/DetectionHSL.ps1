<#
Partie 0 : Préparation des fichiers et dossiers.
#>
Set-location $PSScriptRoot
mkdir DetectionHSL
Set-location ./DetectionHSL
mkdir Partie1 
mkdir Partie2 
mkdir Partie3
mkdir Partie4
mkdir partie5

<#
Partie 1: obtention des logs et des process ouverts
#>


Get-Windowsupdatelog -LogPath partie1\Windowsupdate.log
Get-Process > Partie1\Process.txt
Get-AppBackgroundTask > partie1\Appbackground.txt 
Get-WmiObject -Class Win32_Product > partie1\Applications.txt
Get-AppPackage > partie1\Applicationstore.txt
Get-EventLog -logname system | Tee-Object -filepath partie1\EventLog.txt
Write-Output 'partie 1 terminée'
<#
Partie 2: Obtention des autres infos du pc
#>
Get-volume | Tee-Object -filepath partie2\Partitons.txt
Get-ComputerInfo | Tee-Object -filepath partie2\Infopc.txt 
<#
Partie 3: Vérification de l'état du système.
#>
$prev = [console]::OutputEncoding
[console]::OutputEncoding = [Text.Encoding]::Unicode
SFC /verifyonly | Tee-Object -filepath partie3\sfc.txt
[console]::OutputEncoding = $prev

Dism /online /cleanup-image /scanhealth  | Tee-Object -filepath partie3\Scanhealth.txt
Dism /online /cleanup-image /checkhealth | Tee-Object -filepath partie3\Checkhealth.txt
chkdsk > partie3\chkdsk.txt
<#
Partie 4: Mises a jour de windows.
#>
Update-help
Write-Output 'Si la commande a retourné des erreurs rien de grave.'
install-Module -Name PSWindowsUpdate 
import-module PSWindowsUpdate
Get-WUInstall -AcceptAll –IgnoreReboot


<#
Patie 5: Test de performances.
#>
Winsat formal | Tee-Object -filepath partie5\Winsat.txt
Set-location $PSScriptRoot
Write-Output 'script terminé sans erreurs. Vous pouvez maintenant envoyer le zip pour le dépannage'
timeout /t 180
exit
