impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn string_matching(words: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        let set: HashSet<&str> = words.iter().map(|w| w.as_str()).collect();

        for word in &words {
            for i in 1..word.len() {
                let prefix = &word[..i];
                let suffix = &word[i..];
                if set.contains(prefix) || set.contains(suffix) {
                    result.push(word.clone());
                    break;
                }
            }
        }

        result
    }
}
}