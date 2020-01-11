<#
Partie 5: Test de performances.
#>
cd $PSScriptRoot
.\Additional_exe\o.exe
cd ..
cd Resultats
Winsat formal | Tee-Object -filepath partie5\Winsat.txt
Set-location $PSScriptRoot
cd ..
$azr = pwd
cd Resultats
$path = pwd
cd ..

Compress-Archive -path $path   -DestinationPath $azr\Resultats.zip
Get-filehash -Algorithm sha256 ./Resultats.zip | Tee-Object -filepath .\checksum.txt