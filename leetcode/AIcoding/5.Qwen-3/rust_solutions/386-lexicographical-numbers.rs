impl Solution {

use std::cmp::Ordering;
use std::collections::VecDeque;

impl Solution {
    pub fn lexical_order(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut stack = VecDeque::new();

        for i in 1..=n {
            stack.push_back(i);
        }

        while let Some(num) = stack.pop_front() {
            result.push(num);
            let next = num * 10;
            if next <= n {
                stack.push_back(next);
            }
        }

        result
    }
}
}