impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_time_to_brew_potions(time: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for t in time {
            heap.push(-t);
        }

        let mut time_taken = 0;
        let mut k = k;

        while k > 0 {
            let current = -heap.pop().unwrap();
            time_taken += current;
            heap.push(-(current * 2));
            k -= 1;
        }

        time_taken
    }
}
}