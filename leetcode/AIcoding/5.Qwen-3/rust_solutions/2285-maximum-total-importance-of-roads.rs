impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_total_importance(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut degree = vec![0; n];

        for road in &roads {
            degree[road[0] as usize] += 1;
            degree[road[1] as usize] += 1;
        }

        let mut heap = BinaryHeap::new();
        for i in 0..n {
            heap.push(Reverse(degree[i]));
        }

        let mut value = 0;
        let mut current_value = 1;

        while let Some(Reverse(d)) = heap.pop() {
            value += d * current_value;
            current_value += 1;
        }

        value
    }
}
}