impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distinct_subseq_count(s: String) -> i32 {
        let mod_val = 10_i32.pow(9) + 7;
        let mut dp = vec![0; s.len() + 1];
        dp[0] = 1;
        let mut last = HashMap::new();

        for i in 1..=s.len() {
            let c = &s[i - 1..i];
            dp[i] = (dp[i - 1] * 2) % mod_val;
            if let Some(&prev) = last.get(c) {
                dp[i] = (dp[i] - dp[prev - 1] + mod_val) % mod_val;
            }
            last.insert(c, i);
        }

        dp[s.len()]
    }
}

struct Solution;
}