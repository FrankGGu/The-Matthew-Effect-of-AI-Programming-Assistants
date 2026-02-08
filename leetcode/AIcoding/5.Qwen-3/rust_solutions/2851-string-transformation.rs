impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn str_transform(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut map_s = HashMap::new();
        let mut map_t = HashMap::new();

        for (c_s, c_t) in s.chars().zip(t.chars()) {
            if let Some(&val) = map_s.get(&c_s) {
                if val != c_t {
                    return false;
                }
            } else {
                map_s.insert(c_s, c_t);
            }

            if let Some(&val) = map_t.get(&c_t) {
                if val != c_s {
                    return false;
                }
            } else {
                map_t.insert(c_t, c_s);
            }
        }

        true
    }
}
}