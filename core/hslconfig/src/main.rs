use hslshared;
use std::env;

fn main() {
    println!("Hello, HSLWorld");
    let _args: Vec<String> = env::args().collect();
    
    let isdebug = hslshared::utils::is_debug_env();
    if isdebug == true {
        println!("Debug mode Set!")
    }
}