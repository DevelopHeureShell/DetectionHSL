<#
préparation des fichiers, dossiers et variables
#>
mkdir detectionlog 
mkdir partie1
mkdir partie2
mkdir partie2\sfc
mkdir partie2\dism
mkdir partie3
mkdir partie4

<#Partie 1:logs de Windows Update+process et ping
#>
get-process > partie1\process.txt #liste les processus en arrière plan
ping $toping > partie1\ping.txt #teste le réseau (et le dnsssss)
Get-AppBackgroundTask > partie1\appbackground.txt #liste les application en arrière plan
get-windowsupdatelog -LogPath partie1\windowsupdate.log #crée un fichier journal de windows update
Get-ComputerInfo > partie1\infopc.txt #Récupère beaucoup d'infos sur l'ordinateur
Get-volume > partie1\volumeinfo.txt #informations sur les diques (volumes)

<#
Partie 2:Vérification du système
#>
$prev = [console]::OutputEncoding
[console]::OutputEncoding = [Text.Encoding]::Unicode
SFC /verifyonly | Tee-Object -filepath partie2\sfc.txt
[console]::OutputEncoding = $prev #utilise l'utilitaire sfc pour regarder l'état des fichiers système (aucune réparation) 
echo sfc terminé
dism /online /cleanup-image /scanhealth > partie2\scanhealth.txt #utilise l'utilitaire dism pour vérifier certains fichiers système
dism /online /cleanup-image /checkhealth > partie2\checkhealth.txt #autre vérification dism

<#
Partie 3: Mises à jour de certains programmes (optionel)
#>
Update-help #Met à jour l'aide Powershell

