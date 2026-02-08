impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn smallest_range_ii(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len();
        let mut min_range = nums[n - 1] - nums[0];

        for i in 1..n {
            let mut current_min = nums[0];
            let mut current_max = nums[i - 1];
            for j in i..n {
                current_min = current_min.min(nums[j] - nums[i - 1]);
                current_max = current_max.max(nums[j] + nums[i - 1]);
            }
            min_range = min_range.min(current_max - current_min);
        }

        min_range
    }
}
}