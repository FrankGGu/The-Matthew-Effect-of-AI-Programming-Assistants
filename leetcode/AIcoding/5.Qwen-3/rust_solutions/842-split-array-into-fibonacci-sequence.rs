impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn split_into_fibonacci(mut nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::backtrack(&nums, 0, &mut result, 0, 0, 0);
        result
    }

    fn backtrack(nums: &[i32], start: usize, result: &mut Vec<i32>, a: i32, b: i32, count: usize) -> bool {
        if start == nums.len() {
            return count >= 3;
        }

        for i in start..nums.len() {
            let current = nums[start..i + 1].iter().fold(0, |acc, &num| acc * 10 + num);
            if current > i32::MAX {
                break;
            }

            if result.len() >= 2 {
                let prev = result[result.len() - 1];
                let prev_prev = result[result.len() - 2];
                if current > prev + prev_prev {
                    break;
                }
                if current < prev + prev_prev {
                    continue;
                }
            }

            result.push(current);
            if Self::backtrack(nums, i + 1, result, b, current, count + 1) {
                return true;
            }
            result.pop();
        }

        false
    }
}
}