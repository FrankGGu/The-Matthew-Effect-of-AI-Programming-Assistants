impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn is_isomorphic(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut map_s = HashMap::new();
        let mut map_t = HashMap::new();

        for (c1, c2) in s.chars().zip(t.chars()) {
            match (map_s.get(&c1), map_t.get(&c2)) {
                (Some(&val_s), Some(&val_t)) => {
                    if val_s != c2 || val_t != c1 {
                        return false;
                    }
                }
                (None, None) => {
                    map_s.insert(c1, c2);
                    map_t.insert(c2, c1);
                }
                _ => return false,
            }
        }

        true
    }
}
}