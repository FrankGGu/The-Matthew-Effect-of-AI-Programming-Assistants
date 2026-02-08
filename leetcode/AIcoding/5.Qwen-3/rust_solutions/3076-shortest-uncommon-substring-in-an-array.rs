impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn shortest_uncommon_substring(s: Vec<String>) -> String {
        let n = s.len();
        let mut count = HashMap::new();

        for i in 0..n {
            let word = &s[i];
            for l in 0..word.len() {
                for r in l+1..=word.len() {
                    let substr = &word[l..r];
                    *count.entry(substr).or_insert(0) += 1;
                }
            }
        }

        let mut min_len = usize::MAX;
        let mut result = String::new();

        for i in 0..n {
            let word = &s[i];
            for l in 0..word.len() {
                for r in l+1..=word.len() {
                    let substr = &word[l..r];
                    if count[substr] == 1 {
                        if substr.len() < min_len {
                            min_len = substr.len();
                            result = substr.to_string();
                        }
                    }
                }
            }
        }

        result
    }
}
}