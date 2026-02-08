impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let mut dp = HashMap::new();
        dp.insert(0, 1);

        for num in nums {
            let mut next_dp = HashMap::new();
            for (sum, count) in &dp {
                next_dp.entry(sum + num).or_insert(0).add_assign(*count);
                next_dp.entry(sum - num).or_insert(0).add_assign(*count);
            }
            dp = next_dp;
        }

        dp.get(&target).copied().unwrap_or(0)
    }
}
}