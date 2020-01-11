function Get-Wutils {
    $path = pwd
    cd $path
    Import-module ./Minihsl.psm1
    Import-module ./Extras.psm1
    Import-module ./Internet.psm1
    write-output "Succes"
}

function Get-sha256verify {
    write-output "Quel est le chemin d'acces du fichier?"
    $filepath = Read-host
    write-output "Quel est le Hash que le fichier doit avoir?"
    $hashori = Read-host
    $gethash = get-filehash -algorithm sha256 $filepath
    if ($hashori -eq $gethash) {
        write-output "Le fichier est integre."

    }
    else
    {
        write-output "Attention! Le fichier n'est pas integre!!"
    }

}

function Get-wutilsgithub {
    write-output "https://github.com/woomy4680-exe/woomy_utils"
}


function get-internetping {
    ping /t kernel.org

}
function Get-DISM {
    sfc /scannow
    dism /online /cleanup-image /scanhealth
    dism /online /cleanup-image /checkhealth
    dism /online /cleanup-image /restorehealth
    sfc /scannow
}
function Get-FullHSL {
    <#
Partie 0 : Préparation des fichiers et dossiers.
#>
cd C:/

mkdir Resultats
cd ./Resultats
$path = pwd 
echo $path
mkdir Partie1 
mkdir Partie2 
mkdir Partie3
mkdir Partie4
mkdir partie5

<#
Partie 1: obtention des logs et des process ouverts
#>


Get-Windowsupdatelog -LogPath partie1\Windowsupdate.log
Get-Process > Partie1\Process.txt
Get-AppBackgroundTask > partie1\Appbackground.txt 
Get-WmiObject -Class Win32_Product > partie1\Applications.txt
Get-AppPackage > partie1\Applicationstore.txt
Get-EventLog -logname system | Tee-Object -filepath partie1\EventLog.txt
Write-Output 'partie 1 terminée'
<#
Partie 2: Obtention des autres infos du pc
#>
Get-volume | Tee-Object -filepath partie2\Partitons.txt
Get-ComputerInfo | Tee-Object -filepath partie2\Infopc.txt 
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
<#
Partie 4: Mises à jour.
#>
Update-help
Write-Output 'Si la commande a retourné des erreurs rien de grave.'

<#
Patie 5: Test de performances.
#>
Winsat formal | Tee-Object -filepath partie5\Winsat.txt
Set-location $PSScriptRoot
Write-Output 'script terminé sans erreurs. Vous pouvez maintenant envoyer le zip pour le dépannage'
timeout /t 180
exit

}
function Get-MiniHSL {
    cd C:/

mkdir Resultats
cd ./Resultats
$path = pwd 
echo $path
mkdir Partie1 
mkdir Partie2 
mkdir Partie3

<#
Partie 1: obtention des logs et des process ouverts
#>


Get-Windowsupdatelog -LogPath partie1\Windowsupdate.log
Get-Process > Partie1\Process.txt
Get-AppBackgroundTask > partie1\Appbackground.txt 
Get-WmiObject -Class Win32_Product > partie1\Applications.txt
Get-AppPackage > partie1\Applicationstore.txt
Get-EventLog -logname system | Tee-Object -filepath partie1\EventLog.txt
Write-Output 'partie 1 terminée'
<#
Partie 2: Obtention des autres infos du pc
#>
Get-volume | Tee-Object -filepath partie2\Partitons.txt
Get-ComputerInfo | Tee-Object -filepath partie2\Infopc.txt 

<#
Partie 4: Mises à jour.
#>
Update-help
Write-Output 'Si la commande a retourné des erreurs rien de grave.'

<#
Patie 5: Test de performances.
#>
Winsat formal | Tee-Object -filepath partie3\Winsat.txt
Set-location $path 
Write-Output 'script terminé sans erreurs. Vous pouvez maintenant envoyer le zip pour le dépannage'
timeout /t 180
exit

}
function get-wutilsload {
    write-output "Woomy Utils core loaded."
}
function Get-banned {
    write-output "Vous etes tous bannis !"
}
function Install-GoodSofts {
    choco install chocolateygui powershell-preview powershell-core wsl powertoys grep vim -y
}