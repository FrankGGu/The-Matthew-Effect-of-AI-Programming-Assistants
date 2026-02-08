impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn num_non_decreasing_numbers(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut dp = vec![vec![0; 10]; n as usize + 1];
        for i in 0..10 {
            dp[0][i] = 1;
        }
        for i in 1..n as usize + 1 {
            for j in 0..10 {
                for k in 0..=j {
                    dp[i][j] += dp[i - 1][k];
                }
            }
        }
        let mut result = 0;
        for i in 0..10 {
            result += dp[n as usize][i];
        }
        result
    }
}
}