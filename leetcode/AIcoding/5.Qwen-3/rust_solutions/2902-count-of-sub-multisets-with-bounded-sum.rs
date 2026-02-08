impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn constrained_subset_sum(mut nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut max_deque = std::collections::VecDeque::new();
        let k = k as usize;

        for i in 0..n {
            while let Some(&j) = max_deque.front() {
                if j < i - k {
                    max_deque.pop_front();
                } else {
                    break;
                }
            }

            dp[i] = nums[i];
            if let Some(&j) = max_deque.front() {
                dp[i] = dp[i].max(dp[j] + nums[i]);
            }

            while let Some(&j) = max_deque.back() {
                if dp[j] <= dp[i] {
                    max_deque.pop_back();
                } else {
                    break;
                }
            }

            max_deque.push_back(i);
        }

        *dp.iter().max().unwrap()
    }
}
}