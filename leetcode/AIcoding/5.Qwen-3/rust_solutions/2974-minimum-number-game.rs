impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_number_game(mut nums: Vec<i32>) -> Vec<i32> {
        let mut heap = BinaryHeap::new();
        for num in nums.iter() {
            heap.push(Reverse(*num));
        }

        let mut result = Vec::new();
        while !heap.is_empty() {
            let a = heap.pop().unwrap().0;
            let b = heap.pop().unwrap().0;
            result.push(b);
            result.push(a);
        }

        result
    }
}
}