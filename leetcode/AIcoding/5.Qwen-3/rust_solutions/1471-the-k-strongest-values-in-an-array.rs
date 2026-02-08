impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn get_k_weakest_rows(mat: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut heap = BinaryHeap::new();

        for (i, row) in mat.iter().enumerate() {
            let count = row.iter().sum::<i32>();
            heap.push((count, i));
        }

        let mut result = Vec::with_capacity(k);
        for _ in 0..k {
            if let Some((_, idx)) = heap.pop() {
                result.push(idx as i32);
            }
        }

        result
    }
}
}