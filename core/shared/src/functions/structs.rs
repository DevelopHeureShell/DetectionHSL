use serde::{
    Deserialize,
    Serialize
};
#[derive(Serialize, Deserialize)]
pub struct Config {
    version: VerInfo,
    config: BaseConfig,
}
#[derive(Serialize, Deserialize)]
pub struct BaseConfig {
    lang: String,
}
#[derive(Serialize, Deserialize)]
pub struct VerInfo {
    reltype: String,
    major: i64,
    patch: i64,
    minor: i64,
}
impl VerInfo {
    pub fn up(&mut self) {
        // Up the version to v + 1
        if self.patch >= 9 {
            self.patch = 0;
            if self.minor >= 9 {
                self.minor = 1;
                self.major = self.major + 1;
            } else {
                self.minor = self.minor + 1;
            }
        }
    }
}