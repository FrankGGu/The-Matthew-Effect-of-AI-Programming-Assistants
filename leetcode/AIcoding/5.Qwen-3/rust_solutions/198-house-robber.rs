impl Solution {

use std::cmp;

impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0];
        }
        if n == 2 {
            return nums[0].max(nums[1]);
        }

        let mut prev_prev = nums[0];
        let mut prev = nums[0].max(nums[1]);

        for i in 2..n {
            let current = prev_prev + nums[i];
            let new_prev = prev.max(current);
            prev_prev = prev;
            prev = new_prev;
        }

        prev
    }
}
}