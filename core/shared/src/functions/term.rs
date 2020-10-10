#![macro_use]
pub fn red_print(msg: &str) {
    println!("{}", console::style(msg).red());
}
#[macro_export]
macro_rules! yellow_print {
    ($msg:expr) => {
        println!("{}", console::style($msg).yellow());
    };
}