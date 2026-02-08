impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn split_even(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut remaining = n;
        let mut current = 2;

        while remaining > 0 {
            if remaining - current >= 0 {
                result.push(current);
                remaining -= current;
                current += 2;
            } else {
                result.last_mut().map(|x| *x += remaining);
                break;
            }
        }

        result
    }
}
}