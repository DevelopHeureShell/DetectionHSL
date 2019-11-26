Write-output 'Entrez le chemin de stockage des logs.'
$logpath = Read-host
Write-output 'Les logs seront stockés dans ce dosssier'

cd $logpath
mkdir DetectionHSL
cd ./DetectionHSL
mkdir Partie1 
mkdir Partie2 
mkdir Partie3
mkdir Partie4
mkdir partie5


Write-output 'Arborescence OK'
Write-output 'Ou voulez vous stocker le script (il sera mis a jour )'
$scriptpath = Read-host
Write-output 'Le script sera stocké a cet endroit'

