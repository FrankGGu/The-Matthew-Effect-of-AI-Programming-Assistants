impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimum_length_encoding(mut words: Vec<String>) -> i32 {
        let mut unique_words = HashSet::new();
        for word in &words {
            unique_words.insert(word);
        }

        for word in &words {
            for i in 1..word.len() {
                let suffix = &word[i..];
                unique_words.remove(suffix);
            }
        }

        let mut result = 0;
        for word in unique_words {
            result += word.len() + 1;
        }

        result as i32
    }
}
}