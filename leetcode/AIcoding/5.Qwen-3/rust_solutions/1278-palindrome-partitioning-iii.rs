impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn palindrome_partition(s: String, k: i32) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![0; k as usize]; n];
        let mut cost = vec![vec![0; n]; n];

        for i in 0..n {
            for j in i..n {
                if i == j {
                    cost[i][j] = 0;
                } else {
                    cost[i][j] = cost[i + 1][j - 1] + if s[i] != s[j] { 1 } else { 0 };
                }
            }
        }

        for i in 0..n {
            dp[i][0] = cost[0][i];
        }

        for i in 1..n {
            for j in 1..k as usize {
                dp[i][j] = i32::MAX;
                for m in j as usize - 1..i {
                    dp[i][j] = dp[i][j].min(dp[m][j - 1] + cost[m + 1][i]);
                }
            }
        }

        dp[n - 1][k as usize - 1]
    }
}

struct Solution {}
}