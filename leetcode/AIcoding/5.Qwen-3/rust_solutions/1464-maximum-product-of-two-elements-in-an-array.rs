impl Solution {

use std::cmp;

impl Solution {
    pub fn max_product(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        nums.sort_by(|a, b| b.cmp(a));

        let max1 = nums[0];
        let max2 = nums[1];

        (max1 - 1) * (max2 - 1)
    }
}

struct Solution;
}