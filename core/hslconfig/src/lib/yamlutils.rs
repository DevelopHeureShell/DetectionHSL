extern crate yaml_rust;
use yaml_rust::YamlLoader;
pub fn from_yaml(yamlstr: String) -> std::vec::Vec<yaml_rust::Yaml> {
    let docs = YamlLoader::load_from_str(&yamlstr).unwrap(); 
    return docs;
}