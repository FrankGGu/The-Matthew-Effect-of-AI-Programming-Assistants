impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut sum = 0;
        for &num in &nums {
            sum += num;
        }

        let mut dp = HashMap::new();
        dp.insert(0, 1);

        for &num in &nums {
            let mut new_dp = HashMap::new();
            for (&key, &count) in &dp {
                let new_key = key + num;
                *new_dp.entry(new_key).or_insert(0) += count;
                *new_dp.entry(key).or_insert(0) += count;
            }
            dp = new_dp;
        }

        let total = dp.get(&sum).copied().unwrap_or(0);
        let mut result = 0;
        for (&key, &count) in &dp {
            if (key - (sum - key)).abs() % 2 == 0 {
                result += count;
            }
        }

        result / 2
    }
}
}