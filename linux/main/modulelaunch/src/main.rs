use std::env;
fn main(){
    let args: Vec<String> = env::args().collect();
    let nom = &args[1];
    let auteur = &args[2];
    let version = &args[3]; 
    println!("Lancement du module {} créé par {} en version {}.", nom, auteur, version);
}
//Expected usage: (./)modulelaunch(.exe) ${modulename} ${moduleauthor} ${moduleversion} 