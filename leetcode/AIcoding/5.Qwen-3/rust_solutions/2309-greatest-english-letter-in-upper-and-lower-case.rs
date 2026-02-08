impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn greatest_letter(s: String) -> String {
        let set: HashSet<char> = s.chars().collect();
        let mut result = 'A';

        for c in 'A'..='Z' {
            if set.contains(&c) && set.contains(&c.to_lowercase().next().unwrap()) {
                result = c;
            }
        }

        result.to_string()
    }
}
}