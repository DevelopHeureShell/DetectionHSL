<#
Partie 0 : Préparation des fichiers et dossiers.
#>
cd $PSScriptRoot
Import-module ./Core.psm1
cd ..
cd ./Resultats
$path = pwd 



<#
Partie 2: Obtention des autres infos du pc
#>
cd $PSScriptRoot
.\Additional_exe\h.exe
cd $path 
Get-volume | Tee-Object -filepath partie2\Partitons.txt
cd $PSScriptRoot
.\Additional_exe\i.exe
cd $path
Get-ComputerInfo | Tee-Object -filepath partie2\Infopc.txt 