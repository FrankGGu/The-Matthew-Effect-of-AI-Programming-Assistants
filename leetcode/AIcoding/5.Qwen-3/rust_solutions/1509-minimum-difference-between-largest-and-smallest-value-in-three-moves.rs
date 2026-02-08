impl Solution {

use std::cmp::min;

impl Solution {
    pub fn min_difference(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 4 {
            return 0;
        }
        nums.sort();
        let mut min_diff = i32::MAX;
        for i in 0..4 {
            min_diff = min(min_diff, nums[n - 4 + i] - nums[i]);
        }
        min_diff
    }
}
}