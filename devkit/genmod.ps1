param(
    [string]$name = '' ,
    [string]$author = '', 
    [int]$version 
)
<#
Generates a basic Hslmod without any optionnal configuration like deps

#>
if($name -eq ''){
    Clear-Host
    Write-Host  ''
    Write-Host -ForegroundColor Green "Mode interactif de generation des modules"
    $name = Read-Host "Quel est le nom du module?"
    [int]$version = Read-Host "Quelle est sa version?"
    $author =  Read-Host "Quel(s) est / sont son / ses auteur(s)?"
    #Prompts user
    $hslmod = @{
        name = $name
        version = $version 
        author = $author
        deps = @()
    }
    #this is the config
    Set-Location $PSScriptRoot\..\scripts 
    if(Test-Path $name){
        Write-Host -ForegroundColor Red "Un module du meme nom existe deja."
        exit
    }
    New-Item -ItemType Directory -Name $name | Out-Null
    Set-Location $name 
    New-Item -ItemType File -Name "${name}.ps1" | Out-null
    $hslmod | ConvertTo-Json >> module.json

}
else{ 
$hslmod = @{
        name = $name
        version = $version 
        author = $author
        deps = @()
    }
    #this is the config
    Set-Location $PSScriptRoot\..\scripts 
    if(Test-Path $name){
        Write-Host -ForegroundColor Red "Un module du meme nom existe deja."
        exit  1
    }
    New-Item -ItemType Directory -Name $name | Out-Null
    Set-Location $name 
    New-Item -ItemType File -Name "${name}.ps1" | Out-null
    $hslmod | ConvertTo-Json >> module.json
}