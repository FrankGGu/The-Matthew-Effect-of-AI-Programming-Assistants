impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn length_of_longest_subsequence(nums: Vec<i32>, target: i32) -> i32 {
        let mut dp = vec![0; target as usize + 1];
        for num in nums {
            for i in (num as usize..=target as usize).rev() {
                dp[i] = dp[i].max(dp[i - num as usize] + 1);
            }
        }
        dp[target as usize]
    }
}
}