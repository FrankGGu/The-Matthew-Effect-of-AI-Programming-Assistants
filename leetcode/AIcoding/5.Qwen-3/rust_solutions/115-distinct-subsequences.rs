impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distinct_subseq(a: String) -> i32 {
        let mut dp = vec![0; a.len() + 1];
        dp[0] = 1;
        let mut last = HashMap::new();

        for i in 0..a.len() {
            let c = a.as_bytes()[i];
            dp[i + 1] = (dp[i] * 2) % 1000000007;
            if let Some(&prev) = last.get(&c) {
                dp[i + 1] = (dp[i + 1] - dp[prev]) % 1000000007;
            }
            last.insert(c, i);
        }

        dp[a.len()]
    }
}
}