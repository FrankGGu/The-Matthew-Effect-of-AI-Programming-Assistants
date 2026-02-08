impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_erasure_value(nums: Vec<i32>) -> i32 {
        let mut max_score = 0;
        let mut left = 0;
        let mut seen = HashSet::new();
        let mut current_sum = 0;

        for right in 0..nums.len() {
            while seen.contains(&nums[right]) {
                seen.remove(&nums[left]);
                current_sum -= nums[left];
                left += 1;
            }
            seen.insert(nums[right]);
            current_sum += nums[right];
            max_score = max_score.max(current_sum);
        }

        max_score
    }
}
}