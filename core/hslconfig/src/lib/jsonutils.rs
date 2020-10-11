use hslshared::structs;
pub fn to_json_string(config: structs::Config) -> String {
    let cfg =  serde_json::to_string(&config);  
    match cfg{
        Ok(cfg) => {
            println!("{}", cfg);
            return cfg;
        }
        _ => {
            return "".to_owned();  
        }
    }
}
