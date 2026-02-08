impl Solution {

use std::cmp::Ordering;

struct Solution;

impl Solution {
    pub fn most_competitive_subsequence(mut nums: Vec<i32>) -> Vec<i32> {
        let mut stack = Vec::new();
        let n = nums.len();
        let k = n - 1;

        for num in nums {
            while stack.len() > k && stack.last().unwrap() > &num {
                stack.pop();
            }
            stack.push(num);
        }

        stack.truncate(n - 1);
        stack
    }
}
}