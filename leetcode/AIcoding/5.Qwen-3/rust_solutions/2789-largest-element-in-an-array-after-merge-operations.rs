impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn max_after_merge(mut nums: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }

        while heap.len() > 1 {
            let a = heap.pop().unwrap();
            let b = heap.pop().unwrap();
            let merged = a + b;
            heap.push(merged);
        }

        *heap.peek().unwrap()
    }
}
}