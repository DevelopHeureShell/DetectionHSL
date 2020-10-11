mod lib;
#[macro_use]
extern crate hslshared;
use console;
use clap::{Arg, App, SubCommand};
fn main() {
    let app = App::new("hslconfig")
    .version("3.0.0")
    .about("DetectionHSL Configuration Utility")
    .author("Woomy4680-exe")
    .arg(Arg::with_name("config")
                               .short("c")
                               .long("config")
                               .value_name("FILE")
                               .help("Sets a custom config file")
                               .takes_value(true))
            .subcommand(SubCommand::with_name("test")
            .about("controls testing features")
            .version("3.0.0")
            .author("Someone E. <someone_else@other.com>")
            .arg(Arg::with_name("debug")
                                   .short("d")
                                   .help("print debug information verbosely")))
                               .get_matches();
    let isdebug = hslshared::utils::is_debug_env();
    if isdebug == true {
        yellow_print!("[Debug] HSLconfig: Debug mode set");
    }
    let homecfg = format!("{}/.dhslconfig.yaml", std::env::var("HOME").unwrap());
    let configpath = app.value_of("config").unwrap_or(&homecfg);
    if isdebug == true {
        yellow_print!(format!("[DEBUG] HSLconfig: Loading config file {}", configpath))
    }
    if !std::path::Path::new(configpath).exists() {
        if isdebug {
            red_print!("[ERROR] HSLconfig: Invalid configuration path");
        }
        std::process::exit(1);
    }
    let config = lib::yamlutils::from_yaml(std::fs::read_to_string(configpath).unwrap());
    lib::jsonutils::to_json_string(config);
}