impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn exclusive_time(n: i32, logs: Vec<String>) -> Vec<i32> {
        let mut result = vec![0; n as usize];
        let mut stack = VecDeque::new();
        let mut prev_time = 0;

        for log in logs {
            let parts: Vec<&str> = log.split(':').collect();
            let id = parts[0].parse::<i32>().unwrap();
            let is_start = parts[1] == "start";
            let time = parts[2].parse::<i32>().unwrap();

            if !stack.is_empty() {
                let top_id = *stack.back().unwrap();
                result[top_id as usize] += time - prev_time;
            }

            if is_start {
                stack.push_back(id);
            } else {
                stack.pop_back();
            }

            prev_time = time;
        }

        result
    }
}
}