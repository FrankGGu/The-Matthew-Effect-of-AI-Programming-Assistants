impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn process_tasks(tasks: Vec<Vec<i32>>) -> Vec<i32> {
        let mut queue = VecDeque::new();
        let mut result = Vec::new();
        let mut time = 0;
        let mut i = 0;
        let n = tasks.len();

        while i < n || !queue.is_empty() {
            while i < n && tasks[i][0] <= time {
                queue.push_back((tasks[i][1], tasks[i][2]));
                i += 1;
            }

            if !queue.is_empty() {
                let (duration, priority) = queue.pop_front().unwrap();
                result.push(duration);
                time += duration;
            } else {
                time = tasks[i][0];
            }
        }

        result
    }
}
}