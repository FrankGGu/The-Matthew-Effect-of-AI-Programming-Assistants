impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn single_threaded_cpu(mut tasks: Vec<Vec<i32>>) -> Vec<i32> {
        tasks.sort_by_key(|t| t[0]);
        let mut heap = BinaryHeap::new();
        let mut result = Vec::new();
        let mut i = 0;
        let mut time = 0;

        while i < tasks.len() || !heap.is_empty() {
            if heap.is_empty() {
                time = tasks[i][0];
            }

            while i < tasks.len() && tasks[i][0] <= time {
                heap.push(Reverse((tasks[i][1], tasks[i][0])));
                i += 1;
            }

            if let Some(Reverse((duration, start_time))) = heap.pop() {
                result.push(start_time);
                time += duration;
            }
        }

        result
    }
}
}