impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn repeated_character(s: String) -> char {
        let mut seen = HashSet::new();
        for c in s.chars() {
            if seen.contains(&c) {
                return c;
            }
            seen.insert(c);
        }
        ' '
    }
}
}