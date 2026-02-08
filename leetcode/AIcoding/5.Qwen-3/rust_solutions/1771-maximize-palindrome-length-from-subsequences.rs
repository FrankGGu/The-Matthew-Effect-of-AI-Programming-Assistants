impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_palindrome_length(mut s: String) -> i32 {
        let n = s.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for l in 2..=n {
            for i in 0..n - l + 1 {
                let j = i + l - 1;
                if s.chars().nth(i) == s.chars().nth(j) {
                    dp[i][j] = if l == 2 { 2 } else { dp[i + 1][j - 1] + 2 };
                } else {
                    dp[i][j] = dp[i + 1][j].max(dp[i][j - 1]);
                }
            }
        }

        dp[0][n - 1]
    }
}
}