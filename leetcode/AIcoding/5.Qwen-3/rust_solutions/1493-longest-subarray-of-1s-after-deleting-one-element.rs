impl Solution {

use std::cmp;

impl Solution {
    pub fn longest_after_deleting_one(nums: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut max_len = 0;
        let mut has_deleted = false;

        for right in 0..nums.len() {
            if nums[right] == 0 {
                if has_deleted {
                    while nums[left] == 1 {
                        left += 1;
                    }
                    left += 1;
                } else {
                    has_deleted = true;
                }
            }
            max_len = cmp::max(max_len, right - left + 1);
        }

        max_len as i32
    }
}
}