impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn shortest_completing_word(s: String, words: Vec<String>) -> String {
        let mut count = HashMap::new();
        for c in s.chars() {
            if c.is_alphabetic() {
                *count.entry(c.to_ascii_lowercase()).or_insert(0) += 1;
            }
        }

        let mut min_len = usize::MAX;
        let mut result = String::new();

        for word in words {
            let mut word_count = HashMap::new();
            for c in word.chars() {
                if c.is_alphabetic() {
                    *word_count.entry(c.to_ascii_lowercase()).or_insert(0) += 1;
                }
            }

            let mut valid = true;
            for (k, v) in &count {
                if word_count.get(k).unwrap_or(&0) < v {
                    valid = false;
                    break;
                }
            }

            if valid && word.len() < min_len {
                min_len = word.len();
                result = word;
            }
        }

        result
    }
}
}