impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn sum_of_subarray_ranges(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut min_heap = BinaryHeap::new();
        let mut max_heap = BinaryHeap::new();
        let mut result = 0;

        for i in 0..n {
            let mut left = i;
            while left > 0 && nums[left - 1] < nums[i] {
                left -= 1;
            }
            let mut right = i;
            while right < n - 1 && nums[right + 1] < nums[i] {
                right += 1;
            }
            result += nums[i] * (i - left + 1) * (right - i + 1);
        }

        for i in 0..n {
            let mut left = i;
            while left > 0 && nums[left - 1] > nums[i] {
                left -= 1;
            }
            let mut right = i;
            while right < n - 1 && nums[right + 1] > nums[i] {
                right += 1;
            }
            result -= nums[i] * (i - left + 1) * (right - i + 1);
        }

        result
    }
}
}