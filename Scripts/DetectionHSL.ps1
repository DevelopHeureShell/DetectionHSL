<#
Partie 0 : Préparation des fichiers et dossiers.
#>
cd $PSScriptRoot
Import-module ./Core.psm1
cd ..

mkdir Resultats
cd ./Resultats
$path = pwd 
echo $path
mkdir Partie1 
mkdir Partie2 
mkdir Partie3
mkdir Partie4
mkdir partie5

<#
Partie 1: obtention des logs et des process ouverts
#>
$basepath = pwd
cd ..
cd Scripts
cd Additional_exe
début_partie_1.exe
cd $basepath
get-wutilsload 
start-sleep 10
Get-Windowsupdatelog -LogPath partie1\Windowsupdate.log
Get-Process > Partie1\Process.txt
Get-AppBackgroundTask > partie1\Appbackground.txt 
Get-WmiObject -Class Win32_Product > partie1\Applications.txt
Get-AppPackage > partie1\Applicationstore.txt
Get-EventLog -logname system | Tee-Object -filepath partie1\EventLog.txt

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
Partie 4: Mises à jour.
#>
Update-help
Write-Output 'Si la commande a retourne des erreurs rien de grave.'

<#
Patie 5: Test de performances.
#>
Winsat formal | Tee-Object -filepath partie5\Winsat.txt
Set-location $PSScriptRoot
Write-Output 'script terminé sans erreurs. Vous pouvez maintenant envoyer le zip pour le dépannage'
timeout /t 180
exit
