impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn matrix_sum(mut nums: Vec<Vec<i32>>) -> i32 {
        let mut max_heap = BinaryHeap::new();

        for row in &mut nums {
            for num in row {
                max_heap.push(Reverse(*num));
            }
        }

        let mut result = 0;
        while let Some(Reverse(val)) = max_heap.pop() {
            result += val;
        }

        result
    }
}
}