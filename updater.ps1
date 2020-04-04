$Host.UI.RawUI.WindowTitle = "DetectionHSL Updater"
Set-Location $env:TEMP 
if (Test-path .\hslupdater) {
    Remove-item -recurse hslupdater
}
New-item -ItemType Directory -Name hslupdater | Out-Null
Set-Location hslupdater 
$actual = Get-Content $PSScriptRoot\config.json | ConvertFrom-Json 
Invoke-webrequest -OutFile new.json https://raw.githubusercontent.com/Woomy4680-exe/DetectionHSL/master/config.json
$new = Get-Content new.json | ConvertFrom-Json 
if ($new.version -eq $actual.version) {
    Write-Output "Already up to date"
    Write-Output "Press any key to exit"
    $Host.UI.RawUI.ReadKey() | Out-Null   
    exit 
}
else {
    
    $newver = $new.version.tostring()
    Write-Output "Updating DetectionHSL"
    $url = "https://github.com/Woomy4680-exe/DetectionHSL/archive/${newver}.zip"
    Invoke-WebRequest -OutFile updated.zip $url 
    Expand-Archive updated.zip 
    Set-Location updated 
    Set-Location DetectionHSL-${newver}
    $newhsl = Get-Location
    Set-Location $PSScriptRoot
    $instructions = Get-Content $newhsl\updater.json | ConvertFrom-Json

    foreach ($file in $instructions.files ) {
        if (Test-path $psscriptroot\$file) { Remove-item -Recurse -Force $file }
        Copy-Item -Recurse -Force $newhsl\$file $PSScriptRoot
    }
    Set-location scripts
    $mods = Get-ChildItem $newhsl\scripts
    foreach ($mod in $mods) {
        if (Test-Path $PSScriptRoot\scripts\$mod) { Remove-item -Recurse $mod }
        
        Copy-item -Recurse $newhsl\scripts\$mod $PSScriptRoot\scripts
    }
    Write-Output "Press any key to exit"
    $Host.UI.RawUI.ReadKey() | Out-Null   
}