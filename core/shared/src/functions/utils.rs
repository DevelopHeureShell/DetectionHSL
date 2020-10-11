use std::env;
pub fn is_debug_env() -> bool {
    return match env::var("HSL_DBG") {
        Ok(v) => {
            if v == "true" {
                true
            } else {
                false
            }
        }
        _ => false,
    };
}
