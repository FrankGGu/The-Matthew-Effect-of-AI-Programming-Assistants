impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn arrange_clothes(clothes: Vec<i32>, k: i32) -> Vec<i32> {
        let mut heap = BinaryHeap::new();
        for &cloth in &clothes {
            heap.push(cloth);
        }

        let mut result = Vec::new();
        while !heap.is_empty() {
            let mut temp = Vec::new();
            for _ in 0..k as usize {
                if let Some(val) = heap.pop() {
                    temp.push(val);
                }
            }

            for val in temp.iter().rev() {
                result.push(*val);
            }
        }

        result
    }
}
}