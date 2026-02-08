impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn minimize_max(mut nums: Vec<i32>, p: i32) -> i32 {
        nums.sort();
        let mut left = 0;
        let mut right = nums.last().unwrap() - nums.first().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::can_choose_pairs(&nums, mid) >= p {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }

    fn can_choose_pairs(nums: &[i32], max_diff: i32) -> i32 {
        let mut count = 0;
        let mut i = 0;
        while i < nums.len() - 1 {
            if nums[i + 1] - nums[i] <= max_diff {
                count += 1;
                i += 2;
            } else {
                i += 1;
            }
        }
        count
    }
}
}