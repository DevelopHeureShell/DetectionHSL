
function Test-HSL {
   $prephash = cat .\hash\prep.sha256

   $prephashere = Get-filehash -algorithm sha256 .\prep.ps1

   if($prephashere.hash -eq $prephash){
    write-output "Sys De prep OK!"
   }
   else{
    [int]$errorstate = $errorstate + 1
   }
   $partie1hash = cat .\hash\partie1.sha256

   $partie1hashere = Get-filehash -algorithm sha256 .\partie1.ps1

   if ($partie1hashere.hash -eq $partie1hash){
    write-output "Partie 1 OK!"
   }

   else {
       [int]$errorstate = $errorstate + 1
   }

   $partie2hash = cat .\hash\partie2.sha256

   
   $partie2hashere = Get-filehash -algorithm sha256 .\partie2.ps1 

   
   if ($partie2hashere.hash -eq $partie2hash){
    write-output "Partie2 OK"
   }
   
   else {
       [int]$errorstate = $errorstate + 1
   }
   
   $partie3hash = cat .\hash\partie3.sha256

   
   $partie3hashere = Get-filehash -algorithm sha256 .\partie3.ps1

   if ($partie3hashere.hash -eq $partie3hash){
    write-output "Parite3 OK"
   }
   else {
       [int]$errorstate = $errorstate + 1
   }
   $partie4hash = cat .\hash\partie4.sha256
   
   $partie4hashere = Get-filehash -algorithm sha256 .\partie4.ps1    
  if ($partie4hashere.hash -eq $partie4hash){
    write-output "Partie4 OK"
  }
  else {
   [int]$errorstate = $errorstate + 1
    }

    #Partie5
  
  $partie5hash = cat .\hash\partie5.sha256
  
  
  $partie5hashere = Get-filehash -algorithm sha256 .\partie5.ps1
  
  
  if ($partie5hashere.hash -eq $partie5hash){
    write-output "Partie5 OK"
  }
  else{
    [int]$errorstate = $errorstate + 1
    echo "pas OK"
  }
}


cd $psscriptroot


.\Additional_exe\prepdir.exe
cd ..
if((Test-path ./Resultats ) -eq $true){
    Remove-item -recurse ./Resultats
}
cd scripts
Test-HSL
if ($errorstate -eq 1){
    write-output "Il y a un fichier corrompu"
    pause
    exit
}
elseif ($errorstate -eq 2){
    write-output "Il y a un fichier corrompu"
    pause
    exit

}
elseif ($errorstate -eq 3){
    write-output "Il y a un fichier corrompu"
    pause
    exit
}
elseif ($errorstate -eq 4){
    write-output "Il y a un fichier corrompu"
    pause
    exit
}
elseif ($errorstate -eq 5){
    write-output "Il y a un fichier corrompu"
     pause
    exit
}
elseif ($errorstate -eq 6){
    write-output "Il y a un fichier corrompu"
     pause
    exit
}
else{
    write-output "Il n'y a pas de fichiers corrompus."
}
cd $psscriptroot
cd ..
mkdir Resultats | out-null
cd Resultats 
[string]$path = pwd
mkdir Partie1 | out-null
mkdir Partie2  | out-null
mkdir Partie3 | out-null
mkdir Partie4 | out-null
mkdir partie5 | out-null