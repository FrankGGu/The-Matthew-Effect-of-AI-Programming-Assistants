impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn encode_words(mut words: Vec<String>) -> i32 {
        words.sort_by(|a, b| b.len().cmp(&a.len()));
        let mut suffixes = HashSet::new();
        let mut result = 0;

        for word in words {
            if !suffixes.contains(&word) {
                for i in 1..word.len() {
                    suffixes.insert(&word[i..]);
                }
                result += word.len() + 1;
            }
        }

        result as i32
    }
}
}