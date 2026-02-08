impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn stone_game_vi(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let n = a.len();
        let mut heap = BinaryHeap::new();

        for i in 0..n {
            let total = a[i] + b[i];
            heap.push((std::cmp::Reverse(total), a[i], b[i]));
        }

        let mut alice = 0;
        let mut bob = 0;

        while let Some((_, a_val, b_val)) = heap.pop() {
            alice += a_val;
            bob += b_val;
        }

        match alice.cmp(&bob) {
            Ordering::Greater => vec![1, 0],
            Ordering::Less => vec![0, 1],
            Ordering::Equal => vec![0, 0],
        }
    }
}
}