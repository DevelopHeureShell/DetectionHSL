<#
Bienvenue sur ce script, il a pour but de détecter pas mal d'infos sur votre ordinateur. Il est composé de plusieurs
parties qui sont expliquées dans le readme. 
/!\n'oubliez pas de lire le readme avant de lancer le script/!\
Le script est prêt à l'emploi mais il est conseillé de lire le readme pour adapter certains paramètres.
Vous pouvez utiliser une seule étape dans le dossier du script.
--------------------------------------------------------------------------------------------------------------------------------
Contact:
Github(report bugs):https://github.com/Woomy4680-exe/Script-d-tection-hardware-software
Discord:Woomy4680_exe#6538
Discord du scipt:https://discord.gg/V57eUPX
Telegram:https://t.me/woomy4680_exe
Telegram du scipt:https://t.me/gitwoomy
Reddit:Woomy4680_exe
Mail:woomy4680@gmail.com
#>
<#
préparation des fichiers, dossiers et variables
#>
mkdir detectionlog 
mkdir partie1
mkdir partie2
mkdir partie3
mkdir partie4
cd ./partie2
mkdir sfc
mkdir dism
<#Partie 1:logs de Windows Update+process et ping
#>
cd ./partie1 #se place dans le dossier de la partie 1
get-process > process.txt #liste les processus en arrière plan
ping $toping > ping.txt #teste le réseau (et le dnsssss)
Get-AppBackgroundTask > appbackground.txt #liste les application en arrière plan
get-windowsupdatelog #crée un fichier journal de windows update
Get-ComputerInfo > infopc.txt #Récupère beaucoup d'infos sur l'ordinateur
Get-volume > volumeinfo.txt #informations sur les diques (volumes)
<#
Partie 2:Vérification du système
#>
$prev = [console]::OutputEncoding
[console]::OutputEncoding = [Text.Encoding]::Unicode
SFC /verifyonly | Tee-Object -filepath "D:/detectionlog/partie1/sfc.txt"
[console]::OutputEncoding = $prev #utilise l'utilitaire sfc pour regarder l'état des fichiers système (aucune réparation) 
echo 'sfc fini'
dism /online /cleanup-image /scanhealth >scanhealth.txt #utilise l'utilitaire dism pour vérifier certains fichiers système
dism /online /cleanup-image /checkhealth >checkhealth.txt #autre vérification dism
