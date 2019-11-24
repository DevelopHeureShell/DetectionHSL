<#
Partie 0 : Préparation des fichiers et dossiers.
#>
cd $PSScriptRoot
mkdir DetectionHSL
cd ./DetectionHSL
mkdir Partie1 
mkdir Partie2 
mkdir Partie3
mkdir Partie4

<#
Partie 1: obtention des logs et des process ouverts
#>


Get-Windowsupdatelog -LogPath partie1\Windowsupdate.log
Get-Process > Partie1\process.txt
Get-AppBackgroundTask > partie1\appbackground.txt 
Get-WmiObject -Class Win32_Product > partie1\applications.txt
Get-AppPackage > partie1\applicationstore.txt
echo partie 1 terminée
<#
Partie 2: Obtention des autres infos du pc
#>
Get-volume > partie2\volumeinfo.txt
Get-ComputerInfo > partie2\infopc.txt 
<#
Partie 3: Vérification de l'état du système.
#>
$prev = [console]::OutputEncoding
[console]::OutputEncoding = [Text.Encoding]::Unicode
SFC /verifyonly | Tee-Object -filepath partie3\sfc.txt
[console]::OutputEncoding = $prev

Dism /online /cleanup-image /scanhealth  | Tee-Object -filepath partie3\scanhealth.txt
Dism /online /cleanup-image /checkhealth | Tee-Object -filepath partie3\checkhealth.txt
chkdsk > partie3\chkdsk.txt
Update-help
echo 'Si la commande précédente a donné des erreurs rien de grave.'
<#
Patie 4: Test de performances.
#>
Winsat formal | Tee-Object -filepath partie4\winsat.txt
cd $PSScriptRoot
cd ./outils 
speedtest  | Tee-Object -filepath '$PSScriptRoot\DetectionHSL\partie4\speedtest.txt'
echo 'script terminé sans erreurs vous pouvez maintenant envoyer le zip pour le dépannage'
timeout /t 180
exit
