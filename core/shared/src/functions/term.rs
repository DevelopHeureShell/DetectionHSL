#![macro_use]

#[macro_export]
macro_rules! red_print {
    ($msg:expr) => {
        println!("{}", console::style($msg).red());
    };
}

#[macro_export]
macro_rules! yellow_print {
    ($msg:expr) => {
        println!("{}", console::style($msg).yellow());
    };
}