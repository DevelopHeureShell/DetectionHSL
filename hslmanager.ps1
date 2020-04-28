param (
    [switch]$nogui = $false,
    [switch]$accpetall = $false
)
$hslconf = Get-Content $PSScriptRoot\config.json | ConvertFrom-Json #On load la config
if (!($nogui)) {
    Clear-Host
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
elseif ($args[0] -eq 'update') {
    $execmode = 'update'
}
elseif ($args[0] -eq 'clean') {
    $execmode = 'clean'
}
elseif ($args[0] -eq 'backup') {
    $execmode = 'backup'
}
elseif ($args[0] -eq 'restore') {
    $execmode = "restore"
}
else {
    Write-Output "Arguments invalides"
    $execmode = 'help'
}
if ($execmode -eq "disable") {
    if ($null -eq $args[1]) {
        Write-Host "Il faut indiquer un module"
        Write-Host ''
        Write-Host ''
        exit 1
    }
    $newmods = @()
    foreach ($mod in $hslconf.modules) {
        if (!($mod -eq $args[1])) {
            $newmods += $mod
        }
    }
    $hslconf.modules = $newmods
    if (Test-path $PSScriptRoot\oldconfig.json) { Remove-Item -recurse oldconfig.json }
    Rename-Item $PSScriptRoot\config.json oldconfig.json
    $hslconf | ConvertTo-Json  > $PSScriptRoot\config.json
    exit
} 
if ($execmode -eq 'enable') {
    if ($null -eq $args[1]) {
        Write-Host "Il faut indiquer un module"
        Write-Host ''
        Write-Host ''
        exit 1
    }
    $newmods = @()
    foreach ($mod in $hslconf.modules) {
        if ($args[1] -eq $mod) {
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
if ($execmode -eq 'start') {
    & $PSScriptRoot\start.bat
    exit
}
if ($execmode -eq 'clean') {
    $files = @(
        "hsllog.log",
        "oldconfig.json",
        "DetectionHSL.zip",
        "backup"
    )
    foreach ($file in $files) {
        if (Test-Path $PSScriptRoot\$file) {
            Remove-item -Recurse $PSScriptRoot\$file
        }
    }
    exit
}
if ($execmode -eq 'help') {
    Write-Host -ForegroundColor Green "Aide de DetectionHSL"
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
    Write-Host "Restore: Restaurer une sauvegarde"
    Write-Host "UTILISATION: hslmanager restore [sauvegarde]"
    Write-Host ""
    Write-Host "Backup: Faire une sauvegarde"
    Write-Host "UTILISATION: hslmanager backup [nom]"
    Write-Host ""
}
if ($execmode -eq 'backup') {
    if ($null -eq $args[1]) { return }
    $name = $args[1]
    if (Test-Path $PSScriptRoot\backup\$name) {
        Remove-Item -Recurse $PSScriptRoot\backup\$name
    }
    if (!(Test-Path $PSScriptRoot\backup)) {
        New-Item -ItemType Directory -Path $PSScriptRoot\backup | Out-Null
    }

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
        "loupe.ico",
        'hslmanager.ps1'
    )
    New-Item -ItemType Directory -Path $PSScriptRoot\backup\$name | Out-Null #Creation du dossier de la sauvegarde
    foreach ($file in $tobackup) {
        Copy-Item -Recurse $PSScriptRoot\$file $PSScriptRoot\backup\$name
    }
}
if ($execmode -eq 'restore') {
    if ($null -eq $args[1]) { exit 1 }
    $name = $args[1]
    if (!(Test-Path $PSScriptRoot\backup\$name)) {
        Write-Host 'Sauvegarde invalide'
        exit 1
    }
    if (!($accpetall)) {
        while (!($choice -eq 'y')) {
            Write-Output "Etes vous sur de vouloir restaurer la sauvegarder $name ? [Y|N]"
            $choice = Read-Host 
            if ($choice.ToLower() -eq 'n' ) {
                Write-Host 'Sortie...'
                exit
            }
        }
        $torestore = @(
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
            "loupe.ico",
            'hslmanager.ps1')
        foreach ($file in $torestore) {
            if (Test-Path $PSScriptRoot\$file) { Remove-Item -Recurse $PSScriptRoot\$file }
            Copy-Item -Recurse $PSScriptRoot\backup\$name\$file $PSScriptRoot\$file
          
        }
  Write-Host -ForegroundColor "Green" "OK!"    
}
}
if ($execmode -eq 'update') {
    & $PSScriptRoot\hslmanager.ps1 backup bfrupdate
    Write-Host -ForegroundColor Green "Mise a jour..."
    & $PSScriptRoot\updater.ps1 -accept
}