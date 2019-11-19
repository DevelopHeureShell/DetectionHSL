<#
préparation des fichiers, dossiers et variables
#>
cd "c:/"
mkdir Detectionlog
cd ./Detectionlog 
mkdir Partie1
mkdir Partie2
mkdir Partie3
mkdir Partie4

<#Partie 1:logs de Windows Update+diverses infos
#>
get-process > Partie1\process.txt #liste les processus en arrière plan
ping google.com > Partie1\ping.txt #teste le réseau (et le dnsssss)
Get-AppBackgroundTask > partie1\appbackground.txt #liste les application en arrière plan
get-windowsupdatelog -LogPath partie1\windowsupdate.log #crée un fichier journal de windows update
Get-ComputerInfo > partie1\infopc.txt #Récupère beaucoup d'infos sur l'ordinateur
Get-volume > partie1\volumeinfo.txt #informations sur les diques (volumes)
Get-WmiObject -Class Win32_Product > partie1\applications.txt
Get-AppPackage > partie1\applicationstore.txt 
<#
Partie 2:Vérification du système
#>
$prev = [console]::OutputEncoding
[console]::OutputEncoding = [Text.Encoding]::Unicode
SFC /verifyonly | Tee-Object -filepath partie2\sfc.txt
[console]::OutputEncoding = $prev #utilise l'utilitaire sfc pour regarder l'état des fichiers système (aucune réparation) 
echo sfc fini
dism /online /cleanup-image /scanhealth > partie2\scanhealth.txt #utilise l'utilitaire dism pour vérifier certains fichiers système
dism /online /cleanup-image /checkhealth > partie2\checkhealth.txt #autre vérification dism
#chkdsk > partie2/disquecheck.txt

<#
Partie 3: Mises à jour de certains programmes (optionel)
#>
Update-help #Met à jour l'aide Powershell
