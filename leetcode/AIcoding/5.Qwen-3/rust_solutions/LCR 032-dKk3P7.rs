impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn is_anagram(s: String, t: String) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let mut count = HashMap::new();

        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        for c in t.chars() {
            *count.entry(c).or_insert(0) -= 1;
            if *count.get(&c).unwrap() < 0 {
                return false;
            }
        }

        true
    }
}
}