impl Solution {

use std::cmp;

impl Solution {
    pub fn partition_disjoint(nums: Vec<i32>) -> i32 {
        let mut max_so_far = nums[0];
        let mut partition_index = 0;
        let mut current_max = nums[0];

        for i in 1..nums.len() {
            if nums[i] < max_so_far {
                partition_index = i;
                max_so_far = current_max;
            } else {
                current_max = cmp::max(current_max, nums[i]);
            }
        }

        partition_index as i32
    }
}
}