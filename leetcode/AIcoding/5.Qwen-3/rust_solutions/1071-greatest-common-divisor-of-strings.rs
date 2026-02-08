impl Solution {

use std::cmp::min;

impl Solution {
    pub fn gcd_of_strings(word1: String, word2: String) -> String {
        let len = min(word1.len(), word2.len());
        for i in (1..=len).rev() {
            let candidate = &word1[0..i];
            if word1.replacen(candidate, "", 0) == "" && word2.replacen(candidate, "", 0) == "" {
                return candidate.to_string();
            }
        }
        String::new()
    }
}
}