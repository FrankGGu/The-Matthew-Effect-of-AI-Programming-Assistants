impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut q = VecDeque::new();

        for i in 0..n {
            if nums[i] == 1 {
                dp[i] = 0;
                q.push_back(i);
            } else {
                dp[i] = i32::MAX;
            }
        }

        while let Some(i) = q.pop_front() {
            for j in [i - 1, i + 1].iter() {
                if *j >= 0 && *j < n as usize {
                    if nums[*j] == 1 && dp[*j] > dp[i] + 1 {
                        dp[*j] = dp[i] + 1;
                        q.push_back(*j);
                    }
                }
            }
        }

        let mut res = 0;
        for i in 0..n {
            if nums[i] == 0 {
                if dp[i] == i32::MAX {
                    return -1;
                }
                res += dp[i];
            }
        }

        res
    }
}
}