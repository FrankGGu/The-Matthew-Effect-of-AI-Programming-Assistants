impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn next_greater_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![-1; n];
        let mut stack = VecDeque::new();

        for i in 0..2 * n {
            let idx = i % n;
            while let Some(&top) = stack.back() {
                if nums[top] < nums[idx] {
                    result[top] = nums[idx];
                    stack.pop_back();
                } else {
                    break;
                }
            }
            if i < n {
                stack.push_back(idx);
            }
        }

        result
    }
}
}