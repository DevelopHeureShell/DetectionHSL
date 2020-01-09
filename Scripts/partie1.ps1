<#
Partie 0 : Préparation des fichiers et dossiers.
#>
cd $PSScriptRoot
Import-module ./Core.psm1
cd ..
remove-item -recurse ./Resultats
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
get-wutilsload
Get-Windowsupdatelog -LogPath partie1\Windowsupdate.log
Get-Process > Partie1\Process.txt
Get-AppBackgroundTask > partie1\Appbackground.txt 
Get-WmiObject -Class Win32_Product > partie1\Applications.txt
Get-AppPackage > partie1\Applicationstore.txt
Get-EventLog -logname system | Tee-Object -filepath partie1\EventLog.txt