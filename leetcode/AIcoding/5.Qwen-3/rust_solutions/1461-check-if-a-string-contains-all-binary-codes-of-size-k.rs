impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn has_all_codes_to_string(s: String, k: i32) -> bool {
        let k = k as usize;
        if k == 0 || s.len() < k {
            return true;
        }

        let mut set = HashSet::new();
        let len = s.len();

        for i in 0..=len - k {
            let substr = &s[i..i + k];
            set.insert(substr);
        }

        let required = 1 << k;
        set.len() >= required
    }
}
}