impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn count_pairs(nums: Vec<i32>, target: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut count = 0;
        let mut left = 0;
        let mut right = nums.len() - 1;

        while left < right {
            match (nums[left] + nums[right]).cmp(&target) {
                Ordering::Less => {
                    count += (right - left) as i32;
                    left += 1;
                },
                _ => {
                    right -= 1;
                }
            }
        }

        count
    }
}
}