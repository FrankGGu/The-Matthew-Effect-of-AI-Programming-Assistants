impl Solution {

use std::collections::BinaryHeap;

struct Solution {}

impl Solution {
    pub fn nth_smallest_amount(coins: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut visited = std::collections::HashSet::new();
        let k = k as usize;

        heap.push((-coins[0], 0));
        visited.insert(0);

        for _ in 0..k {
            let (val, idx) = heap.pop().unwrap();
            let val = -val;

            if idx + 1 < coins.len() {
                let next_idx = idx + 1;
                let next_val = val + coins[next_idx];

                if !visited.contains(&next_val) {
                    visited.insert(next_val);
                    heap.push((-next_val, next_idx));
                }
            }

            if idx > 0 {
                let prev_idx = idx - 1;
                let prev_val = val - coins[idx];

                if !visited.contains(&prev_val) {
                    visited.insert(prev_val);
                    heap.push((-prev_val, prev_idx));
                }
            }

            if _ == k - 1 {
                return val;
            }
        }

        -1
    }
}
}