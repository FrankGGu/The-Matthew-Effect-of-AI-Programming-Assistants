impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn longest_subarray(nums: Vec<i32>, limit: i32) -> i32 {
        let mut max_deque = VecDeque::new();
        let mut min_deque = VecDeque::new();
        let mut left = 0;
        let mut result = 0;

        for right in 0..nums.len() {
            while let Some(&last) = max_deque.back() {
                if nums[last] < nums[right] {
                    max_deque.pop_back();
                } else {
                    break;
                }
            }
            max_deque.push_back(right);

            while let Some(&last) = min_deque.back() {
                if nums[last] > nums[right] {
                    min_deque.pop_back();
                } else {
                    break;
                }
            }
            min_deque.push_back(right);

            while nums[max_deque[0]] - nums[min_deque[0]] > limit {
                left += 1;
                if max_deque[0] < left {
                    max_deque.pop_front();
                }
                if min_deque[0] < left {
                    min_deque.pop_front();
                }
            }

            result = result.max((right - left + 1) as i32);
        }

        result
    }
}
}