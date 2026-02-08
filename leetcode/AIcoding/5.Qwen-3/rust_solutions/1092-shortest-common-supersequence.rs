impl Solution {

use std::cmp::min;

impl Solution {
    pub fn shortest_common_supersequence(mut s1: String, mut s2: String) -> String {
        let m = s1.len();
        let n = s2.len();
        let mut dp = vec![vec![0; n + 1]; m + 1];

        for i in 0..m {
            for j in 0..n {
                if s1[i] == s2[j] {
                    dp[i + 1][j + 1] = dp[i][j] + 1;
                } else {
                    dp[i + 1][j + 1] = min(dp[i + 1][j], dp[i][j + 1]);
                }
            }
        }

        let mut i = m;
        let mut j = n;
        let mut result = Vec::new();

        while i > 0 || j > 0 {
            if i > 0 && j > 0 && s1[i - 1] == s2[j - 1] {
                result.push(s1[i - 1]);
                i -= 1;
                j -= 1;
            } else if i > 0 && (j == 0 || dp[i][j] == dp[i - 1][j]) {
                result.push(s1[i - 1]);
                i -= 1;
            } else {
                result.push(s2[j - 1]);
                j -= 1;
            }
        }

        result.into_iter().rev().collect()
    }
}
}