param(
    [string]$path = "",
    [string]$name = ""
)
<#
Script qui check si:
-Le module est OK
et le pack
#>
if($path -eq ''){
    Write-Host -ForegroundColor Red "Missing parameter: Path"
    exit 1 
}
if($name -eq ''){
    Write-Host -ForegroundColor red "Missing parametter: Name"
    exit 1 
}
$path = Resolve-Path $path
Write-Host -foregroundcolor green "Packing module ${path}..."
Set-Location $PSScriptRoot
Set-Location .. 
$hslroot = Get-Location 
if(Test-Path $hslroot\scripts\$name){
    Set-Location $hslroot\scripts\$name 
    if((Get-Location) -eq $path){
        return 
    }
    else{
        Write-Host -ForegroundColor Red "A module called ${name} already exists!"
        exit 1 
    }
}

