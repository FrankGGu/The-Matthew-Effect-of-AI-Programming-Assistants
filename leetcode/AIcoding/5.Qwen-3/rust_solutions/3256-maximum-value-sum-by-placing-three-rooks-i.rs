impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_value_sum(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        for row in &grid {
            for &val in row {
                max_heap.push(Reverse(val));
            }
        }

        let mut sum = 0;
        let mut count = 0;

        while let Some(Reverse(val)) = max_heap.pop() {
            if count < 3 {
                sum += val;
                count += 1;
            } else {
                break;
            }
        }

        sum
    }
}
}