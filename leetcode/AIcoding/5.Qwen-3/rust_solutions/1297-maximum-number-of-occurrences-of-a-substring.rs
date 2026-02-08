impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_number_of_occurrences(s: String, sub: String) -> i32 {
        let mut map = HashMap::new();
        let s_len = s.len();
        let sub_len = sub.len();

        for i in 0..=s_len - sub_len {
            let substr = &s[i..i + sub_len];
            *map.entry(substr).or_insert(0) += 1;
        }

        map.values().copied().max().unwrap_or(0)
    }
}
}