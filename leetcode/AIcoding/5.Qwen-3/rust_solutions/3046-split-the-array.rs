impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn split_array(nums: Vec<i32>, m: i32) -> bool {
        let m = m as usize;
        let n = nums.len();
        let mut dp = vec![vec![false; n]; m + 1];
        let mut prefix_sum = vec![0; n];
        prefix_sum[0] = nums[0];
        for i in 1..n {
            prefix_sum[i] = prefix_sum[i - 1] + nums[i];
        }

        for i in 0..n {
            dp[1][i] = true;
        }

        for k in 2..=m {
            for i in 0..n {
                for j in 0..i {
                    if dp[k - 1][j] && prefix_sum[i] - prefix_sum[j] >= prefix_sum[j] - prefix_sum[0] {
                        dp[k][i] = true;
                        break;
                    }
                }
            }
        }

        dp[m][n - 1]
    }
}
}