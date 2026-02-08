impl Solution {

use std::collections::VecDeque;

struct Solution {}

impl Solution {
    pub fn process_tasks(tasks: Vec<Vec<i32>>) -> Vec<i32> {
        let mut tasks = tasks;
        let n = tasks.len();
        let mut result = Vec::with_capacity(n);
        let mut queue = VecDeque::new();

        for i in 0..n {
            while !queue.is_empty() && queue.front().unwrap()[1] <= tasks[i][0] {
                let task = queue.pop_front().unwrap();
                result.push(task[2]);
            }

            queue.push_back(tasks[i].clone());
        }

        while !queue.is_empty() {
            let task = queue.pop_front().unwrap();
            result.push(task[2]);
        }

        result
    }
}
}