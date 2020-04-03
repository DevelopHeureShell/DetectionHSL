$Host.UI.RawUI.WindowTitle = "DetectionHSL Downloader"
New-item -ItemType Directory -Path $PSScriptRoot\DetectionHSL | Out-null
Set-Location $env:TEMP 
if(Test-path .\hsldownloader) {
    Remove-item -recurse hsldownloader
}
New-item -ItemType Directory -Name hsldownloader | Out-Null
Set-Location hsldownloader
Invoke-webrequest -OutFile new.json https://raw.githubusercontent.com/Woomy4680-exe/DetectionHSL/master/config.json
$new = Get-Content new.json | ConvertFrom-Json 
$newver = $new.version.tostring()
Write-Output "Downloading DetectionHSL version $newver"
$url = "https://github.com/Woomy4680-exe/DetectionHSL/archive/${newver}.zip"
Invoke-WebRequest -OutFile updated.zip $url 
Expand-Archive updated.zip 
Set-Location updated 
Set-Location DetectionHSL-${newver}
Copy-item -recurse .\* $PSScriptRoot
Set-Location $PSScriptRoot\DetectionHSL