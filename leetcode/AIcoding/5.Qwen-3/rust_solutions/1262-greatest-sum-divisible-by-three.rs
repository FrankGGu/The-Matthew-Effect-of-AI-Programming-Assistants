impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn max_sum_div_three(nums: Vec<i32>) -> i32 {
        let mut dp = [0, 0, 0];

        for num in nums {
            let mut new_dp = dp.clone();
            for i in 0..3 {
                if dp[i] != 0 || i == 0 {
                    let remainder = (dp[i] + num) % 3;
                    match new_dp[remainder].cmp(&(dp[i] + num)) {
                        Ordering::Less => new_dp[remainder] = dp[i] + num,
                        _ => {}
                    }
                }
            }
            dp = new_dp;
        }

        dp[0]
    }
}
}