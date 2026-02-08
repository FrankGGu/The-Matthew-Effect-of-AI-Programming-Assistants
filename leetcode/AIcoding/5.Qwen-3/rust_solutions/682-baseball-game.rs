impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn cal_points(operations: Vec<String>) -> i32 {
        let mut stack = VecDeque::new();

        for op in operations {
            match op.as_str() {
                "C" => {
                    stack.pop_back();
                },
                "D" => {
                    if let Some(&val) = stack.back() {
                        stack.push_back(val * 2);
                    }
                },
                "F" => {
                    if let Some(&val) = stack.back() {
                        stack.push_back(val + stack.get(stack.len() - 2).copied().unwrap_or(0));
                    }
                },
                _ => {
                    if let Ok(num) = op.parse::<i32>() {
                        stack.push_back(num);
                    }
                }
            }
        }

        stack.iter().sum()
    }
}
}