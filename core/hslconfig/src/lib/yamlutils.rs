use hslshared::structs;
extern crate yaml_rust;
use yaml_rust::YamlLoader;
pub fn from_yaml(yamlstr: String) -> structs::Config {
    let docs = &YamlLoader::load_from_str(&yamlstr).unwrap()[0];
    structs::Config {
        version: structs::VerInfo {
            reltype: docs["version"]["reltype"].as_str().unwrap().to_owned(),
            minor: docs["version"]["minor"].as_str().unwrap().to_owned(),
            major: docs["version"]["major"].as_str().unwrap().to_owned(),
            patch: docs["version"]["patch"].as_str().unwrap().to_owned(),
        },
        config: structs::BaseConfig {
            lang: docs["config"]["lang"].as_str().unwrap().to_owned(),
        },
    }
}
