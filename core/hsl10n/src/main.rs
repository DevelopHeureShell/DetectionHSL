use std::path::{
    Path
};

use structopt::StructOpt;
mod lib;

#[derive(StructOpt, Debug)]
#[structopt(name = "hsl10n")]
struct Opt {
    #[structopt(short, long)]
    file: Vec<String>,
    #[structopt(short, long)]
    msg: Vec<String>
}

fn main() {
    
    let opt = Opt::from_args();
    let file = format!("{}", opt.file[0]);
    if !Path::new(&file).exists() {
        println!("Le fichier {} n'existe pas!", file);
        std::process::exit(1);
    }
    if opt.file[0] == "" || opt.msg[0] == "" {
        std::process::exit(1);
    }
    lib::yaml::get_lang_message(file, &opt.msg[0]);
}