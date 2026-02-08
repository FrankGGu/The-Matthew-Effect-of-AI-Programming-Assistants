impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_total_freq(nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut max_freq = 0;
        let mut sorted_nums: Vec<_> = freq.into_iter().map(|(num, count)| (num, count)).collect();
        sorted_nums.sort_by(|a, b| a.0.cmp(&b.0));

        let mut left = 0;
        let mut total = 0;

        for right in 0..sorted_nums.len() {
            total += sorted_nums[right].1;

            while total > k {
                total -= sorted_nums[left].1;
                left += 1;
            }

            max_freq = max_freq.max(total);
        }

        max_freq
    }
}
}