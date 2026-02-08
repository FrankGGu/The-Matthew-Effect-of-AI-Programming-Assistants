impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn max_number_of_tasks(mut tasks: Vec<i32>, mut workers: Vec<i32>, coins: i32) -> i32 {
        tasks.sort_unstable();
        workers.sort_unstable();

        let mut task_idx = 0;
        let mut worker_idx = 0;
        let mut result = 0;

        while task_idx < tasks.len() && worker_idx < workers.len() {
            if tasks[task_idx] <= workers[worker_idx] + coins {
                result += 1;
                task_idx += 1;
                worker_idx += 1;
            } else {
                worker_idx += 1;
            }
        }

        result
    }
}
}