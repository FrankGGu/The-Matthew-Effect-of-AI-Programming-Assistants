impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn check_if_pangram(sentence: String) -> bool {
        let mut set = HashSet::new();
        for c in sentence.chars() {
            if c.is_ascii_lowercase() {
                set.insert(c);
            }
        }
        set.len() == 26
    }
}
}