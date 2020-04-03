If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs
    Exit
}
<#
Joli titre, c'est drôle
#>
$host.ui.RawUI.WindowTitle = "DetectionHSL"
<#
On mettra la langue plus tard
On crée les fonctions, essentielles pour le script 
La fonction pour CAT-RUST
Qui s'utilise comme ça : Write-hslcat("file.extentsion")
#>
function Write-Hslcat {
    param(
        [string]$file = ""
    )
    if ($file -eq "") { break }
    & $maindir\cat.exe $PSScriptRoot\$file

}
<#Le Start-HSLmod
Qui récuperera dans $modules (une array) le nom des modules et les lancera en PRocess wait
Elle fonctionne comme ça :
Start-hslmod("name")
Vous n'avez pas besoin de l'utiliser étant donné que l'array du paramètre -modules 
est automatiquement  exécuteée
#>
function Start-HSLmod { 
    param(
        [string]$name = ""
    )
    
    Start-Process powershell.exe "-File $modulesdir\$name\$name.ps1 -Runas "-Wait
}

<#Init de HSL, c'est ici qu'on balance nos modules
On commence par vérifier les dépendences 
#>
Set-Location $PSScriptRoot
Set-Location ..
do { Set-Location .. }
while (!(Test-Path .\main))
$config = Get-Content .\config.json | ConvertFrom-Json
$modules = $config.modules
Set-Location main 
$maindir = Get-Location
if ((Test-path .\cat.exe) -eq $false) {
    & $PSScriptRoot\deps.exe 
    Start-Sleep 50
    exit
}
if ((Test-Path .\dbghsl.exe) -eq $false) {
    & $PSScriptRoot\deps.exe 
    Start-Sleep 50
    exit
}
Set-Location $PSScriptRoot

<#
On log la liste des modules à load.
#>
Clear-Host
Write-Output "Bienvenue sur DetectionHSL!"
write-output ""
write-output "//  //       ///////    //"
write-output "//  //     ////         //"
write-output "//////      ///////     //"
write-output "//  //          ///     //"
write-output "//  //    //////         //////"
write-output ""
Write-hslcat("listing.txt")
foreach($mod in $modules){
    $mod
}

<#
On crée les dossiers comme $env:temp\DetectionHSL 
Et on prend les variables du genre $modulesdir
Et on crée LE HSL Log 
#>
Set-Location $env:TEMP
if (Test-path .\detectionhsl) { Remove-Item -Recurse -Force .\detectionhsl }
New-Item -ItemType Directory -Name detectionhsl | Out-Null
Set-Location detectionhsl 
$hsldir = Get-Location
Set-Location $PSScriptRoot 
Set-Location .. 
$modulesdir = Get-Location
Set-Location $hsldir
<#
Petite boucle qui se charge de créer les dossiers modules.
#>
Write-Hslcat("directory.txt")
foreach($mod in $modules){
    New-Item -ItemType Directory -Name $mod | Out-Null
}
Set-Location $modulesdir 
Set-Location .. 
<#
Ready to LOG!
On va récup le STDOUT pour le début du LOG
#> 
if (Test-Path .\hsllog.log) { Remove-Item .\hsllog.log }
foreach($mod in $modules){
    $mod >> hsllog.log
}
$logpath = Get-Location
#Lancement des modules
foreach($mod in $modules) {
    $hslmod = Get-Content $modulesdir\$mod\module.json | ConvertFrom-Json
    & $maindir\modulelaunch.exe $hslmod.name $hslmod.author $hslmod.version
    Start-HSLmod($mod)
    if (!($?)) {
        Write-Output  "Le module ${mod} a eu une erreur" >> $logpath\hsllog.log
    }
}