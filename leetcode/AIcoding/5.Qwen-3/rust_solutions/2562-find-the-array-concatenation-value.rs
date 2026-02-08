impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_concatenation_value(mut nums: Vec<i32>) -> i32 {
        let mut result = 0;
        let mut queue = VecDeque::new();

        for num in nums.iter() {
            queue.push_back(*num);
        }

        while let Some(front) = queue.pop_front() {
            if let Some(back) = queue.pop_back() {
                result += front * 10_i32.pow(back.to_string().len() as u32) + back;
            } else {
                result += front;
            }
        }

        result
    }
}
}