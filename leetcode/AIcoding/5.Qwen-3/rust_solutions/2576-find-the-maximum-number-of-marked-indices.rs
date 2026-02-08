impl Solution {

use std::cmp::Reverse;

impl Solution {
    pub fn max_marked_indices(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len();
        let mut marked = 0;
        let mut j = (n + 1) / 2;

        for i in 0..(n + 1) / 2 {
            if j < n && nums[i] * 2 <= nums[j] {
                marked += 1;
                j += 1;
            }
        }

        marked as i32
    }
}
}