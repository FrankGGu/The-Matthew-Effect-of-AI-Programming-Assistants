impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_product_subseqs(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; 101]; n + 1];
        for i in 0..n {
            dp[i + 1][0] = 1;
        }

        for i in 1..=n {
            for j in 0..=k as usize {
                dp[i][j] = dp[i - 1][j];
                if j >= nums[i - 1] as usize {
                    dp[i][j] = dp[i][j].max(dp[i - 1][j - nums[i - 1] as usize] * nums[i - 1]);
                }
            }
        }

        dp[n][k as usize]
    }
}
}