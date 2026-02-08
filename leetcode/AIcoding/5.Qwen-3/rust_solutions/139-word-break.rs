impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn word_break(s: String, word_dict: Vec<String>) -> bool {
        let word_set: HashSet<_> = word_dict.into_iter().collect();
        let mut dp = vec![false; s.len() + 1];
        dp[0] = true;

        for i in 1..=s.len() {
            for j in 0..i {
                if dp[j] && word_set.contains(&s[j..i]) {
                    dp[i] = true;
                    break;
                }
            }
        }

        dp[s.len()]
    }
}
}