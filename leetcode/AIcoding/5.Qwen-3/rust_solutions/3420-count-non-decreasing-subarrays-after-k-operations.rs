impl Solution {

use std::cmp;

impl Solution {
    pub fn count_non_decreasing_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut result = 0;
        let mut left = 0;
        let mut prev = nums[0];
        for right in 1..n {
            if nums[right] < prev {
                let length = right - left;
                result += (length as i64) * (length as i64 + 1) / 2;
                left = right;
                prev = nums[right];
            } else {
                prev = nums[right];
            }
        }
        let length = n - left;
        result += (length as i64) * (length as i64 + 1) / 2;
        result
    }
}
}