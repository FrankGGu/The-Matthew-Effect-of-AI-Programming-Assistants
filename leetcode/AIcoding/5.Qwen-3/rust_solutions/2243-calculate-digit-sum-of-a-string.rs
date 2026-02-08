impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn get_digit_sum(s: String) -> String {
        let mut queue = VecDeque::new();
        for c in s.chars() {
            queue.push_back(c);
        }

        while queue.len() > 1 {
            let mut new_queue = VecDeque::new();
            let mut i = 0;
            while i < queue.len() {
                let mut sum = 0;
                for j in 0..2 {
                    if i + j < queue.len() {
                        sum += queue[i + j].to_digit(10).unwrap();
                    }
                }
                new_queue.push_back(sum.to_string());
                i += 2;
            }
            queue = new_queue;
        }

        queue.pop_front().unwrap()
    }
}
}