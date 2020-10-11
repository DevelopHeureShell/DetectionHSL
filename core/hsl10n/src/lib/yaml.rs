extern crate yaml_rust;
use yaml_rust::YamlLoader;

pub fn get_lang_message(jpath: String, msgname: &str) {
    match std::fs::read_to_string(jpath) {
        Ok(f) => {
            let docs = YamlLoader::load_from_str(&f).unwrap();
            if let Some(d) = &docs[0][msgname].as_str() {
                println!("{}", d)
            }
        }
        Err(e) => {
            println!("Erreur: {:?}", e)
        }
    };
}    
