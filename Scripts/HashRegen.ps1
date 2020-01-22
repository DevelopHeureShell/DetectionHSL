#Fonctions
function Clear-oldhash{
    Write-output "Suppresion des vieux hash..."
    Set-location $psscriptroot
        if((Test-path .\hash) -eq $true){
        Remove-item -Recurse .\hash
        }
    mkdir hash | Out-null
    Set-location hash 
    [string]$hashdir = Get-location
    cd ..

    }
    function Get-Newhash{
        write-output "Regen des hashs"
        Set-location $psscriptroot 
        Set-location hash
        $hashdir = Get-location
        cd ..
        $prephash = Get-filehash -Algorithm SHA256 .\prep.ps1
        write-output $prephash.hash >> .\hash\prep.sha256
    
        $partie1hash = Get-filehash -algorithm sha256 .\partie1.ps1
        write-output $partie1hash.hash >> .\hash\partie1.sha256

        $partie2hash = Get-filehash -algorithm sha256 .\partie2.ps1 
        write-output $partie2hash.hash >> .\hash\partie2.sha256

        $partie3hash = Get-filehash -algorithm sha256 .\partie3.ps1
        write-output $partie3hash.hash >> .\hash\partie3.sha256

        $partie4hash = Get-filehash -algorithm sha256 .\partie4.ps1 
        write-output $partie4hash.hash >> .\hash\partie4.sha256 

        $partie5hash = Get-filehash -algorithm sha256 .\partie5.ps1 
        write-output $partie5hash.hash >> .\hash\partie5.sha256

    }
    function Get-verify{
        Set-location $psscriptroot
        set-location hash
        if((Test-path .\partie1.sha256) -eq $false){
            [int]$nonexistentfiles = $nonexistentfiles + 1 
        }
        if ((Test-path .\partie2.sha256) -eq $false){
            [int]$nonexistentfiles = $nonexistentfiles + 1
        }
        if ((Test-path .\partie3.sha256) -eq $false){
            [int]$nonexistentfiles = $nonexistentfiles + 1
        }
        if ((Test-path .\partie4.sha256) -eq $false){
            [int]$nonexistentfiles = $nonexistentfiles + 1
        }
        if ((Test-path .\partie5.sha256) -eq $false){
            [int]$nonexistentfiles = $nonexistentfiles + 1
        }
        if ((Test-path .\prep.sha256) -eq $false){
            [int]$nonexistentfiles = $nonexistentfiles + 1
        }
        if ($nonexistentfiles -gt 1){
            write-output "Il y a des fichiers corrompus"
            Get-Startmain
        }
        else{
            write-output "Fichiers Ok!"
        }
    }


    function Send-endmessage{
        Write-output "Regen des hash OK!" 
        pause
    }
function Get-Startmain{ 
    write-output "Regen des Hash."
    Clear-oldhash
    Get-Newhash
    Get-verify
    Send-endmessage
    

}
###############################
#Début du script
Get-Startmain

