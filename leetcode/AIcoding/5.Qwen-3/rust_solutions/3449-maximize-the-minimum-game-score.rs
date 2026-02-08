impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn minimize_max(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for &num in &nums {
            heap.push(Reverse(num));
        }

        for _ in 0..k {
            let Reverse(a) = heap.pop().unwrap();
            let Reverse(b) = heap.pop().unwrap();
            heap.push(Reverse((a + b) / 2));
        }

        let Reverse(result) = heap.pop().unwrap();
        result
    }
}
}