impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn prefix_count(words: Vec<String>, prefix: String) -> i32 {
        let mut count = 0;
        for word in words {
            if word.starts_with(&prefix) {
                count += 1;
            }
        }
        count
    }
}
}