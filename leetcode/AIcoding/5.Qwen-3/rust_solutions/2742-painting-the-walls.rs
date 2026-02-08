impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_moves(nums: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }
        let mut moves = 0;
        while heap.len() > 1 {
            let a = heap.pop().unwrap();
            let b = heap.pop().unwrap();
            let sum = a + b;
            moves += sum;
            heap.push(sum);
        }
        moves
    }
}

struct Solution;
}