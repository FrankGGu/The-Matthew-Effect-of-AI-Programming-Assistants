impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_pair_sum(mut nums: Vec<i32>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        for num in &nums {
            max_heap.push(Reverse(*num));
        }
        let mut max_sum = 0;
        while let (Some(Reverse(a)), Some(Reverse(b))) = (max_heap.pop(), max_heap.pop()) {
            max_sum = max_sum.max(a + b);
        }
        max_sum
    }
}
}