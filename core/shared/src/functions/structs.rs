use serde::{Deserialize, Serialize};
#[derive(Serialize, Deserialize, Debug)]
pub struct Config {
    pub version: VerInfo,
    pub config: BaseConfig,
}
#[derive(Serialize, Deserialize, Debug)]
pub struct BaseConfig {
    pub lang: String,
}
#[derive(Serialize, Deserialize, Debug)]
pub struct VerInfo {
    pub reltype: String,
    pub major: String,
    pub patch: String,
    pub minor: String,
}
