impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_occurrences(text: String, first: String, second: String) -> Vec<String> {
        let text: Vec<&str> = text.split_whitespace().collect();
        let mut result = Vec::new();
        for i in 0..text.len() - 2 {
            if text[i] == first && text[i + 1] == second {
                result.push(text[i + 2].to_string());
            }
        }
        result
    }
}
}