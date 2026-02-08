impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn min_subsequence_sum(nums: Vec<i32>, limit: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for &num in &nums {
            for i in (1..=n).rev() {
                if dp[i - 1] != i32::MAX {
                    match dp[i].cmp(&(dp[i - 1] + num)) {
                        Ordering::Greater => dp[i] = dp[i - 1] + num,
                        _ => {}
                    }
                }
            }
        }

        let mut result = i32::MAX;
        for i in 1..=n {
            if dp[i] <= limit {
                result = result.min(dp[i]);
            }
        }

        result
    }
}
}