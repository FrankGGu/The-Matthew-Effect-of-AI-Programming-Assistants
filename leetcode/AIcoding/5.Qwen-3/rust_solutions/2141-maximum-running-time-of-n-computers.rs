impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn max_running_time(n: i32, mut m: i32, mut batteries: Vec<i32>) -> i32 {
        batteries.sort_unstable();
        let mut heap = BinaryHeap::new();

        for _ in 0..n {
            heap.push(batteries.pop().unwrap());
        }

        while let Some(mut battery) = batteries.pop() {
            let min = *heap.peek().unwrap();
            if battery < min {
                heap.push(battery);
                break;
            }
            heap.push(battery - min);
        }

        heap.into_iter().sum()
    }
}

struct Solution {}
}