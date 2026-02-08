impl Solution {

use std::cmp::max;

impl Solution {
    pub fn max_and_sum(nums: Vec<i32>, num_slots: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; 1 << num_slots as usize]; n];
        let mut mask = 0;
        for i in 0..n {
            for j in 0..(1 << num_slots as usize) {
                let mut max_val = 0;
                for k in 0..num_slots {
                    if (j & (1 << k)) == 0 {
                        let new_mask = j | (1 << k);
                        let current = (nums[i] & ((1 << k) - 1)) << (k * 2);
                        max_val = max(max_val, dp[i - 1][j] + current);
                    }
                }
                dp[i][j] = max_val;
            }
        }
        *dp[n - 1].iter().max().unwrap()
    }
}
}