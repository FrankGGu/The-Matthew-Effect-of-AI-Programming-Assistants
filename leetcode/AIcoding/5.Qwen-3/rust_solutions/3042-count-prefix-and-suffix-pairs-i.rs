impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn prefix_suffix_match(words: Vec<String>) -> i32 {
        let mut count = 0;
        let n = words.len();
        for i in 0..n {
            for j in i + 1..n {
                if words[i].starts_with(&words[j]) && words[i].ends_with(&words[j]) {
                    count += 1;
                }
            }
        }
        count
    }
}
}