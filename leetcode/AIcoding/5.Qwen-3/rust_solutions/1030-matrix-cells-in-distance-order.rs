impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn all_cells_distance_order(row_count: i32, col_count: i32) -> Vec<Vec<i32>> {
        let mut heap = BinaryHeap::new();
        for r in 0..row_count {
            for c in 0..col_count {
                heap.push((std::cmp::Reverse(r + c), r, c));
            }
        }

        let mut result = Vec::new();
        while let Some((_, r, c)) = heap.pop() {
            result.push(vec![r, c]);
        }

        result
    }
}
}