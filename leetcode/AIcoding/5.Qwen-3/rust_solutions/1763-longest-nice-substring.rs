impl Solution {

use std::cmp;

impl Solution {
    pub fn longest_nice_substring(s: String) -> String {
        fn is_nice(s: &str) -> bool {
            let mut set = std::collections::HashSet::new();
            for c in s.chars() {
                set.insert(c);
            }
            for c in s.chars() {
                if !set.contains(&c.to_ascii_uppercase()) || !set.contains(&c.to_ascii_lowercase()) {
                    return false;
                }
            }
            true
        }

        let mut max_len = 0;
        let mut result = String::new();

        for i in 0..s.len() {
            for j in i + 1..=s.len() {
                let substr = &s[i..j];
                if is_nice(substr) {
                    if substr.len() > max_len {
                        max_len = substr.len();
                        result = substr.to_string();
                    }
                }
            }
        }

        result
    }
}
}