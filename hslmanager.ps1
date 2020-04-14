param (
    [switch]$nogui = $false 
)
$hslconf = Get-Content $PSScriptRoot\config.json | ConvertFrom-Json #On load la config
if(!($nogui)){
$text = "DetectionHSL Manager version " + $hslconf.version
Write-Host ''
Write-Host "-------------"
Write-Host $text
Write-Host "-------------"
}
if ($null -eq $args[0] -or $args[0] -eq "help" -or $args[0] -eq '?') {
    #On passe en mode HELP si y'a pas d'argss
    $execmode = "help"
}
elseif ($args[0] -eq 'start') {
    #Ici on vérifie si ça rentre dans Start
    $execmode = 'start'
}
elseif ($args[0] -eq 'enable') {
    #Ici on passe en mode Activation de modules si nécessaire
    $execmode = 'enable'
}
elseif ($args[0] -eq 'disable') {
    $execmode = 'disable'
}
elseif($args[0] -eq 'update'){
    $execmode = 'update'
}
elseif($args[0] -eq 'clean'){
    $execmode = 'clean'
}
elseif($args[0] -eq 'backup'){
    $execmode = 'backup'
}
elseif($args[0] -eq 'check'){
    $execmode = 'check'
}
else {
    Write-Output "Arguments invalides"
    $execmode = 'help'
}

if ($execmode -eq "disable"){
    if ($null  -eq $args[1]){
        Write-Host "Il faut indiquer un module"
        Write-Host ''
        Write-Host ''
        exit 1
    }
    $newmods = @()
    foreach ($mod in $hslconf.modules) {
        if(!($mod -eq $args[1])){
            $newmods += $mod
        }
    }
    $hslconf.modules = $newmods
    if(Test-path $PSScriptRoot\oldconfig.json){ Remove-Item -recurse oldconfig.json}
    Rename-Item $PSScriptRoot\config.json oldconfig.json
    $hslconf | ConvertTo-Json  > $PSScriptRoot\config.json
    exit
} #Si on est en disable il exit, un peu plus opti

if($execmode -eq 'enable'){
    if ($null -eq $args[1]) {
        Write-Host "Il faut indiquer un module"
        Write-Host ''
        Write-Host ''
        exit 1
    }
    $newmods = @()
    foreach($mod in $hslconf.modules){
        if($args[1] -eq $mod){
            Write-Host "Module deja actif"
            exit 1
        }
        $newmods += $mod
    }
    $newmods += $args[1]
    $hslconf.modules = $newmods
    if (Test-path $PSScriptRoot\oldconfig.json) { Remove-Item -recurse oldconfig.json }
    Rename-Item $PSScriptRoot\config.json oldconfig.json
    $hslconf | ConvertTo-Json  > $PSScriptRoot\config.json
    exit
}
if ($execmode -eq 'start'){
    & $PSScriptRoot\start.bat
    exit
}
if($execmode -eq 'clean'){
    $files = @(
        "hsllog.log",
        "oldconfig.json",
        "DetectionHSL.zip",
        "backup"
    )
    foreach($file in $files){
        if(Test-Path $PSScriptRoot\$file){
            Remove-item -Recurse $PSScriptRoot\$file
        }
    }
    exit
}
if ($execmode -eq 'help'){
    Write-Host -ForegroundColor Green "Aide de DetectionHSL"
    Write-Host ""
    Write-Host "Utilisation : hslmanager [commande]"
    Write-Host ""
    Write-Host "Clean: Nettoyer les fichiers inutiles de DetectionHSL"
    Write-Host "UTILISATION: hslmanager clean"
    Write-Host ""
    Write-Host "Disable: Desactive un module"
    Write-Host "UTILISATION: hslmanager disable [module]"
    Write-Host ""
    Write-Host "Enable: Activer un module"
    Write-Host "UTILISATION: hslmanager enable [module]"
    Write-Host ""
    Write-Host "Start: Lancer DetectionHSL"
    Write-Host "UTILISATION: hslmanager start"
    Write-Host ""
    Write-Host "Check: Verifier que l'envirronement est correct"
    Write-Host "UTILISATION: hslmanager check"
    Write-Host ""
}
if($execmode -eq 'backup'){
    & $PSScriptRoot\hslmanager.ps1 clean -nogui
    New-Item -ItemType Directory -Path $PSScriptRoot\backup | Out-Null
    Set-Location $PSScriptRoot
    $tobackup = @(
        "HSLlogo.png",
        ".gitignore",
        "config.json",
        "start.bat", 
        "update.bat",
        "updater.json",
        "updater.ps1",
        "gui.ps1",
        "scripts", 
        "main",
        "README.md", 
        "LICENSE",
        "loupe.ico"
    )
    foreach($file in $tobackup){
        Copy-Item -Recurse $PSScriptRoot\$file $PSScriptRoot\backup\
    }
}
if($execmode -eq 'check'){
    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
        Write-Host "Pas lancé en admin"
        exit 1
    }
}