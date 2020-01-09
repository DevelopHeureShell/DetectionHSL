<#
Partie 0 : Préparation des fichiers et dossiers.
#>
cd $PSScriptRoot
Import-module ./Core.psm1
cd ..
cd ./Resultats
$path = pwd 
echo $path

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