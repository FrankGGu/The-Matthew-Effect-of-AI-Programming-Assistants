impl Solution {

use std::cmp;

impl Solution {
    pub fn maximum_sum_pair(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let mut max_sum = i32::MIN;
        for i in (0..nums.len()).step_by(2) {
            if i + 1 < nums.len() {
                max_sum = cmp::max(max_sum, nums[i] + nums[i + 1]);
            }
        }
        max_sum
    }
}
}