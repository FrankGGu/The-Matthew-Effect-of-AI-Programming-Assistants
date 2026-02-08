impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn find_max_length(nums: Vec<i32>) -> i32 {
        let mut dp = vec![0; nums.len()];
        let mut max_len = 0;

        for i in 0..nums.len() {
            for j in 0..i {
                if nums[j] < nums[i] && dp[j] + 1 > dp[i] {
                    dp[i] = dp[j] + 1;
                }
            }
            max_len = max_len.max(dp[i]);
        }

        max_len + 1
    }
}
}