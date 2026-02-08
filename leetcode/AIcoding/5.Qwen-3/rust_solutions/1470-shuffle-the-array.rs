impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn shuffle(nums: Vec<i32>, n: i32) -> Vec<i32> {
        let n = n as usize;
        let mut result = Vec::with_capacity(n * 2);
        let mut left = nums[..n].to_vec();
        let mut right = nums[n..].to_vec();

        while !left.is_empty() {
            result.push(left.remove(0));
            result.push(right.remove(0));
        }

        result
    }
}
}