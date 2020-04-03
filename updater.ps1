Set-Location $env:TEMP 
if(Test-path .\hslupdater){
    Remove-item -recurse hslupdater
}
New-item -ItemType Directory -Name hslupdater | Out-Null
Set-Location hslupdater 
$actual = Get-Content $PSScriptRoot\config.json | ConvertFrom-Json 
Invoke-webrequest -OutFile new.json https://raw.githubusercontent.com/Woomy4680-exe/DetectionHSL/master/config.json
$new = Get-Content new.json | ConvertFrom-Json 
if($new.version -eq $actual.version){
    Write-Output "Already up to date"
    Write-Output "Press any key to exit"
    $Host.UI.RawUI.ReadKey() | Out-Null   
    exit 
}
else{
    $newver = $new.version.tostring()
    Write-Output "Updating DetectionHSL"
    $url = "https://github.com/Woomy4680-exe/DetectionHSL/archive/${newver}.zip"
    Invoke-WebRequest -OutFile updated.zip $url 
    Expand-Archive updated.zip 
    Set-Location updated 
    Set-Location DetectionHSL-${newver}
    $newhsl = Get-Location
    Set-Location $PSScriptRoot
    $files = @("config.json", "hdk", "main", "documentation", "README.md", "start.bat", ".gitignore")
    foreach($file in $files ){
        Remove-item -Recurse -Force $file 
        Copy-Item $newhsl\$file $PSScriptRoot
    }
}