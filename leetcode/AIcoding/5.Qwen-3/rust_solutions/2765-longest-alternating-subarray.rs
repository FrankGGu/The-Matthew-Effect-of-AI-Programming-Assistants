impl Solution {

use std::cmp;

impl Solution {
    pub fn longest_alternating_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut max_len = 1;
        let mut current_len = 1;

        for i in 1..n {
            if (nums[i] > nums[i - 1] && nums[i - 1] < nums[i - 2]) || (nums[i] < nums[i - 1] && nums[i - 1] > nums[i - 2]) {
                current_len += 1;
                max_len = cmp::max(max_len, current_len);
            } else {
                current_len = 1;
            }
        }

        max_len
    }
}
}