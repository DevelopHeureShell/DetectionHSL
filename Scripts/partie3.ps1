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
cd $PSScriptRoot
.\Additional_exe\j.exe
cd $path 
$prev = [console]::OutputEncoding
[console]::OutputEncoding = [Text.Encoding]::Unicode
SFC /verifyonly | Tee-Object -filepath partie3\sfc.txt
[console]::OutputEncoding = $prev
cd $PSScriptRoot
.\Additional_exe\k.exe
cd $path
Dism /online /cleanup-image /scanhealth  | Tee-Object -filepath partie3\Scanhealth.txt
cd $PSScriptRoot
.\Additional_exe\l.exe
cd $path
Dism /online /cleanup-image /checkhealth | Tee-Object -filepath partie3\Checkhealth.txt
cd $PSScriptRoot
.\Additional_exe\m.exe
cd $path
chkdsk > partie3\chkdsk.txt