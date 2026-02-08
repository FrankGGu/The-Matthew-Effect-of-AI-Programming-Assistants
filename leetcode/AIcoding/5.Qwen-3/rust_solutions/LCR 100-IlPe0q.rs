impl Solution {

use std::cmp::min;

impl Solution {
    pub fn minimum_total(triangle: Vec<Vec<i32>>) -> i32 {
        let n = triangle.len();
        let mut dp = triangle.clone();

        for i in 1..n {
            for j in 0..=i {
                if j == 0 {
                    dp[i][j] += dp[i-1][j];
                } else if j == i {
                    dp[i][j] += dp[i-1][j-1];
                } else {
                    dp[i][j] += min(dp[i-1][j-1], dp[i-1][j]);
                }
            }
        }

        *dp[n-1].iter().min().unwrap()
    }
}
}