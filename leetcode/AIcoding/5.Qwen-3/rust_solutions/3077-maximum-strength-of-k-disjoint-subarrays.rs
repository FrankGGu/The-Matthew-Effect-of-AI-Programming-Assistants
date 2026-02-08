impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_sum_split(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut dp = vec![vec![-1000000000; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k {
                if j > 0 {
                    dp[i][j] = dp[i - 1][j - 1].max(dp[i - 1][j]);
                }
                let current = nums[i - 1];
                for l in 1..=i {
                    if j > 0 {
                        let sum = nums[l - 1..i].iter().sum::<i32>();
                        dp[i][j] = dp[l - 1][j - 1].saturating_add(sum).max(dp[i][j]);
                    }
                }
            }
        }

        dp[n][k]
    }
}

struct Solution;
}