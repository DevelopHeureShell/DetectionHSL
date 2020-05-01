function Get-Goodenv {
  If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Output "Vous DEVEZ lancer le script en admin"
    exit
  }
  while ((Test-path ./.gitignore ) -eq $false) {
    Set-Location ..
  }
  Start-Sleep 10
}


function New-Hslmod {
  param(
    [string]$name = ""
  )
  if ($name -eq "") { break }
  if ((Test-path .\scripts ) -eq $true) { Set-Location .\scripts }
  else { Write-Output "Veuillez vous rendre dans le dossier racine" ; break }
  if (Test-Path .\$name) { Write-Output "Ce module existe deja" ; Set-Location .. ; break }
  New-Item -ItemType Directory -Name $name | Out-Null
  Set-Location $name | Out-Null
  New-Item -ItemType Directory -Name debug | Out-Null
}