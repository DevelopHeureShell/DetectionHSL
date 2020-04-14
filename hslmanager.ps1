$hslconf = Get-Content $PSScriptRoot\config.json | ConvertFrom-Json #On load la config
$text = "DetectionHSL Manager version " + $hslconf.version
Write-Host ''
Write-Host ''
Write-Host "-------------"
Write-Host $text
Write-Host "-------------"
if ($null -eq $args[0] -or $args[0] -eq "help" -or $args[0] -eq '?') {
    #On passe en mode HELP si y'a pas d'argss
    $execmode = "help"
}
elseif ($args[0] -eq 'install' -or $args[0] -eq 'i') {
    #Ici on vérifie si ça peut rentrer dans install
    $execmode = 'install'
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
}