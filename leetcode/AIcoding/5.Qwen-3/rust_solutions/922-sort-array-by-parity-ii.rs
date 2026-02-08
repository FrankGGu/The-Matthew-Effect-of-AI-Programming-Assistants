impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn sort_array_by_parity_ii(mut nums: Vec<i32>) -> Vec<i32> {
        let mut even = VecDeque::new();
        let mut odd = VecDeque::new();

        for num in nums.iter() {
            if *num % 2 == 0 {
                even.push_back(*num);
            } else {
                odd.push_back(*num);
            }
        }

        let mut result = Vec::new();
        while !even.is_empty() && !odd.is_empty() {
            result.push(even.pop_front().unwrap());
            result.push(odd.pop_front().unwrap());
        }

        while !even.is_empty() {
            result.push(even.pop_front().unwrap());
        }

        while !odd.is_empty() {
            result.push(odd.pop_front().unwrap());
        }

        result
    }
}

struct Solution;
}