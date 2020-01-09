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
Get-volume | Tee-Object -filepath partie2\Partitons.txt
Get-ComputerInfo | Tee-Object -filepath partie2\Infopc.txt 