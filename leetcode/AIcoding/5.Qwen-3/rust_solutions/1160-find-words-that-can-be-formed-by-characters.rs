impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_characters(words: Vec<String>) -> i32 {
        let mut char_count = HashMap::new();
        for c in "abcdefghijklmnopqrstuvwxyz".chars() {
            *char_count.entry(c).or_insert(0) += 1;
        }

        let mut result = 0;

        for word in words {
            let mut word_count = HashMap::new();
            for c in word.chars() {
                *word_count.entry(c).or_insert(0) += 1;
            }

            let mut can_form = true;
            for (c, &count) in &word_count {
                if char_count.get(c).unwrap_or(&0) < &count {
                    can_form = false;
                    break;
                }
            }

            if can_form {
                result += word.len() as i32;
            }
        }

        result
    }
}
}