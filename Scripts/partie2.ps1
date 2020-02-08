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
cd partie2
if ((Test-Path .\Computerinfo.txt) -eq $true){
    do {
        Remove-Item -Recurse .\Computerinfo.txt  
    }
    while((Test-Path .\Computerinfo.txt) -eq $true)
    
}
$computerinfo  = Get-ComputerInfo
#On prends les objets, pour les renvoyer dans Computerinfo.txt
Write-Output "La version COMPLETE de Windows" >> Computerinfo.txt
write-output $computerinfo.WindowsBuildLabEx >> Computerinfo.txt
Write-Output "La version de NT" >> Computerinfo.txt
Write-Output $computerinfo.WindowsCurrentVersion >> Computerinfo.txt
Write-Output "La date d'installation de Windows" >> Computerinfo.txt #Pour avoir une idée de l'état du système
Write-Output $computerinfo.WindowsInstallDateFromRegistry >> Computerinfo.txt
Write-Output "L'edition de Windows" >> Computerinfo.txt
Write-Output $computerinfo.WindowsProductName >> Computerinfo.txt
Write-Output "Le dossier Windows" >> Computerinfo.txt 
Write-Output $computerinfo.WindowsSystemRoot >> Computerinfo.txt
Write-Output "La version de Windows (ex: 1909)" >> Computerinfo.txt
Write-Output $computerinfo.WindowsVersion >> Computerinfo.txt
Write-Output "Le langage du BIOS" >> Computerinfo.txt #Utile si il faut le reparamétrer
Write-Output $computerinfo.BiosCurrentLanguage >> Computerinfo.txt
Write-Output "Le type d'amorcage" >> Computerinfo.txt
Write-Output $computerinfo.BiosFirmwareType >> Computerinfo.txt
Write-Output "La date du BIOS" >> Computerinfo.txt
Write-Output $computerinfo.BiosReleaseDate >> Computerinfo.txt
Write-Output "La version du BIOS" >> Computerinfo.txt
Write-Output $computerinfo.BiosVersion >> Computerinfo.txt
Write-Output "La version du SMBIOS" >> Computerinfo.txt
[string]$smbiosminorversion = $computerinfo.BiosSMBIOSMinorVersion
[string]$smbiosmajorversion = $computerinfo.BiosSMBIOSMajorVersion
$smbiosversion  = $smbiosmajorversion + '.' + $smbiosminorversion
Write-Output $smbiosversion >> Computerinfo.txt
write-output "La marque du PC:" >> Computerinfo.txt
Write-Output $computerinfo.CsManufacturer >> Computerinfo.txt
Write-Output "Les cartes reseau" >> Computerinfo.txt
Write-Output $computerinfo.CsNetworkAdapters >> Computerinfo.txt
write-output "Le processeur" >> Computerinfo.txt
Write-Output $computerinfo.CsProcessors >> Computerinfo.txt
Write-Output "Les coeurs logiques du processeur" >> Computerinfo.txt
Write-Output $computerinfo.CsNumberOfLogicalProcessors >> Computerinfo.txt
Write-Output "Le type de systeme" >> Computerinfo.txt #Les bits
Write-Output $computerinfo.CsSystemType >> Computerinfo.txt
Write-Output "Le build de l'OS"  >> Computerinfo.txt #Alias Winver
Write-Output $computerinfo.OsVersion >> Computerinfo.txt
Write-Output "La langue de l'OS"  >> Computerinfo.txt #Pour les paramètres
Write-Output $computerinfo.OsLocale >> Computerinfo.txt
Write-Output "La prevention de l'exection des donnees" >> Computerinfo.txt #Ca peut toujours servir
Write-Output $computerinfo.OsDataExecutionPreventionAvailable >> Computerinfo.txt
Write-Output "Pour les drivers" >> Computerinfo.txt
Write-Output $computerinfo.OsDataExecutionPreventionDrivers >> Computerinfo.txt 
Write-Output "La police de la DEP" >> Computerinfo.txt
Write-Output $computerinfo.OsDataExecutionPreventionSupportPolicy >> Computerinfo.txt 
Write-Output "Pour les application 32 Bits" >> Computerinfo.txt
Write-Output $computerinfo.OsDataExecutionPrevention32BitApplications >> Computerinfo.txt
Write-Output "Le mode Debug de l'OS" >> Computerinfo.txt
Write-Output $computerinfo.OsDebug >> Computerinfo.txt
Write-Output "La location des pagefiles" >> Computerinfo.txt
Write-Output $computerinfo.OsPagingFiles >> Computerinfo.txt
Write-Output "La Timezone" >> Computerinfo.txt
Write-Output $computerinfo.TimeZone >> Computerinfo.txt
Write-Output "La taille totale du Swap" >> Computerinfo.txt
Write-Output $computerinfo.OsTotalVirtualMemorySize >> Computerinfo.txt
Write-Output "La taille de la RAM" >> Computerinfo.txt
Write-Output $computerinfo.CsPhysicallyInstalledMemory >> Computerinfo.txt
cd $path