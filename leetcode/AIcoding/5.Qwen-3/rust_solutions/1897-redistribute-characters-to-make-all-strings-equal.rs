impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn check_won(letters: Vec<char>) -> bool {
        let mut freq = HashMap::new();
        for c in letters {
            *freq.entry(c).or_insert(0) += 1;
        }
        for &count in freq.values() {
            if count % letters.len() != 0 {
                return false;
            }
        }
        true
    }

    pub fn is_equal_possible(mut s: Vec<String>) -> bool {
        let mut all_chars = Vec::new();
        for string in s.iter_mut() {
            all_chars.extend(string.chars());
        }
        Self::check_won(all_chars)
    }
}
}