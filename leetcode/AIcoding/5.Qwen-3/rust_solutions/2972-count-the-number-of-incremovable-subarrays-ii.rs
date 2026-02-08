impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn reason(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left = 0;
        while left < n - 1 && nums[left] < nums[left + 1] {
            left += 1;
        }
        if left == n - 1 {
            return (n * (n + 1) / 2) as i32;
        }
        let mut right = n - 1;
        while right > 0 && nums[right - 1] < nums[right] {
            right -= 1;
        }
        let mut res = 0;
        let mut j = right;
        for i in 0..=left {
            while j < n && nums[i] > nums[j] {
                j += 1;
            }
            res += (n - j) as i32;
        }
        res
    }
}
}