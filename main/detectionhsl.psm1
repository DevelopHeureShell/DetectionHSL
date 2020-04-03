function Write-Hslcat {
    param(
        [string]$file = ""
    )
    if ($file -eq "") { break }
    & $maindir\cat.exe $PSScriptRoot\$file

}