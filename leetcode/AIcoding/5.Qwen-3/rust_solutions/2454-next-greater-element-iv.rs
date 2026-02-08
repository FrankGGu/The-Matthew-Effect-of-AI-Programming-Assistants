impl Solution {

use std::collections::VecDeque;

struct Solution {}

impl Solution {
    pub fn next_greater_element(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![-1; n];
        let mut stack = VecDeque::new();

        for i in 0..n {
            while let Some(&j) = stack.back() {
                if nums[j] < nums[i] {
                    result[j] = nums[i];
                    stack.pop_back();
                } else {
                    break;
                }
            }
            stack.push_back(i);
        }

        result
    }
}
}