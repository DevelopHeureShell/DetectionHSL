param(
    [string]$path = "",
    [string]$name = ""
)
if ($path -eq '') {
    Write-Host -ForegroundColor Red "Missing parameter: Path"
    exit 1 
}
if ($name -eq '') {
    Write-Host -ForegroundColor red "Missing parametter: Name"
    exit 1 
}
$path = Resolve-Path $path
Set-Location $path 
#Run test
$modcommonfiles = @("$name.ps1", 'module.json')
foreach($file in $modcommonfiles){
    if(!(Test-Path $path\$file)){
        Write-Host -ForegroundColor Red "Missing file $file"
        exit 1 
    }
}
$conf = Get-Content $path\module.json
if(!$conf.name){
    Write-Host -ForegroundColor Red "Missing config element: name"
    exit  1
}
if (!$conf.author) {
    Write-Host -ForegroundColor Red "Missing config element: author"
    exit  1
}
if (!$conf.version) {
    Write-Host -ForegroundColor Red "Missing config element: version"
    exit  1
}
if (!$conf.deps) {
    Write-Host -ForegroundColor Red "Missing config element: deps"
    exit  1
}