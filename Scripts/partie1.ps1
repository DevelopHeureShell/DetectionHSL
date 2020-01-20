<#
Partie 0 : Préparation des fichiers et dossiers.
#>
cd $PSScriptRoot
cd ..
cd ./Resultats
$path = pwd 

cd $path 


<#
Partie 1: obtention des logs et des process ouverts
#>

cd $PSScriptRoot
.\Additional_exe\a.exe
cd $path
Get-Windowsupdatelog -LogPath partie1\Windowsupdate.log
cd $PSScriptRoot
.\Additional_exe\b.exe
cd $path
Get-Process > Partie1\Process.txt
cd $PSScriptRoot
.\Additional_exe\c.exe
cd $path
Get-AppBackgroundTask > partie1\Appbackground.txt 
cd $PSScriptRoot
.\Additional_exe\d.exe
cd $path
Get-WmiObject -Class Win32_Product > partie1\Applications.txt
cd $PSScriptRoot
.\Additional_exe\e.exe
cd $path 
Get-AppPackage > partie1\Applicationstore.txt
cd $PSScriptRoot
.\Additional_exe\f.exe
cd $path
Get-EventLog -logname system | Tee-Object -filepath partie1\EventLog.txt