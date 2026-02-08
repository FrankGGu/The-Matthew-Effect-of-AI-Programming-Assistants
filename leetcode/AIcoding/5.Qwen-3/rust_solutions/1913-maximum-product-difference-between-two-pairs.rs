impl Solution {

use std::cmp;

impl Solution {
    pub fn max_product_difference(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len();
        (nums[n - 1] * nums[n - 2]) - (nums[0] * nums[1])
    }
}

struct Solution;
}