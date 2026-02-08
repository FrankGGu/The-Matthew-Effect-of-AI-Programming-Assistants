impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut res = 0;

        for i in 0..k {
            let mut sub = vec![];
            for j in (i..n).step_by(k) {
                sub.push(nums[j]);
            }

            let mut dp = vec![1; sub.len()];
            for (i, &num) in sub.iter().enumerate() {
                for j in 0..i {
                    if sub[j] <= num {
                        dp[i] = dp[i].max(dp[j] + 1);
                    }
                }
            }

            let max_len = *dp.iter().max().unwrap();
            res += (sub.len() - max_len) as i32;
        }

        res
    }
}
}