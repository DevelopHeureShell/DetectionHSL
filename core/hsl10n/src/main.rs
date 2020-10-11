#[macro_use]
extern crate hslshared;
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
    if hslshared::utils::is_debug_env() {
        yellow_print!(format!("[DEBUG] HSL10N: Priting langage string {}", opt.msg[0]));
        
    }
    lib::yaml::get_lang_message(file, &opt.msg[0]);
}