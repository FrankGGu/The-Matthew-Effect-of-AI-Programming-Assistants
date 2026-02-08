impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

struct KthLargest {
    heap: BinaryHeap<i32>,
    k: i32,
}

impl KthLargest {
    fn new(mut nums: Vec<i32>, k: i32) -> Self {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }
        while heap.len() > k as usize {
            heap.pop();
        }
        KthLargest { heap, k }
    }

    fn add(&mut self, val: i32) -> i32 {
        self.heap.push(val);
        if self.heap.len() > self.k as usize {
            self.heap.pop();
        }
        *self.heap.peek().unwrap()
    }
}
}