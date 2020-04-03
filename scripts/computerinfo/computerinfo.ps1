$hslmod = Get-Content $PSScriptRoot\module.json | ConvertFrom-Json
Set-Location $PSScriptRoot 
Set-Location ..
Set-Location ..
Set-Location .\main
$host.ui.RawUI.WindowTitle = $hslmod.name + " version " + $hslmod.version + " par " + $hslmod.author
$maindir = Get-Location
function Write-Hslcat {
    param(
        [string]$file = ""
    )
    if ($file -eq "") { break }
    & $maindir\cat.exe $PSScriptRoot\$file

}
Set-Location $env:TEMP\detectionhsl\computerinfo\
$computerinfo = Get-ComputerInfo
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
$smbiosversion = $smbiosmajorversion + '.' + $smbiosminorversion
Write-Output $smbiosversion >> Computerinfo.txt
write-output "La marque du PC:" >> Computerinfo.txt
Write-Output $computerinfo.CsManufacturer >> Computerinfo.txt
Write-Output "Les infos reseau: " >> computerinfo.txt 
$list = $computerinfo.CsNetworkAdapters | Format-List -Property Description, ConnectionID, DHCPEnabled, ConnectionStatus
$list >> computerinfo.txt 
#Pas de IPLEAK
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
##
Get-Volume | Format-List -Property DriveLetter, Friendlyname, FileSystem, HealthStatus, Size >> Volumes.txt