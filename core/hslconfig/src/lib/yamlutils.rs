extern crate yaml_rust;
use yaml_rust::{YamlLoader, Yaml};
pub fn from_yaml(yamlstr: String) -> std::vec::Vec<Yaml> {
    let docs = YamlLoader::load_from_str(&yamlstr).unwrap();
    docs
}