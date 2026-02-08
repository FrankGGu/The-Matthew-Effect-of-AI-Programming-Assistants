impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn put_marbles(mut weights: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        if k == 1 || weights.len() == 0 {
            return 0;
        }

        let mut max_heap = BinaryHeap::new();
        for i in 0..weights.len() - 1 {
            max_heap.push(Reverse(weights[i] + weights[i + 1]));
        }

        let mut total = 0;
        for _ in 0..k - 1 {
            if let Some(Reverse(val)) = max_heap.pop() {
                total += val;
            }
        }

        total as i64
    }
}
}