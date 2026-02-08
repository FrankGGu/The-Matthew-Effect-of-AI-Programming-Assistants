impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_great_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut dp = vec![0; k as usize];
        dp[0] = 1;

        for (&num, &count) in &freq {
            let mut new_dp = dp.clone();
            for i in 0..k as usize {
                if dp[i] > 0 {
                    for j in 1..=count {
                        let target = (i + j as i32) % k;
                        new_dp[target] = (new_dp[target] + dp[i]) % 1_000_000_007;
                    }
                }
            }
            dp = new_dp;
        }

        dp[0]
    }
}
}