impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn security_check(people: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut queue = VecDeque::new();
        for i in 0..people.len() {
            queue.push_back(i as i32);
        }

        let mut result = Vec::new();
        let mut step = 0;
        while !queue.is_empty() {
            step += 1;
            let front = queue.pop_front().unwrap();
            if step % k as usize == 0 {
                result.push(front);
            } else {
                queue.push_back(front);
            }
        }
        result
    }
}
}