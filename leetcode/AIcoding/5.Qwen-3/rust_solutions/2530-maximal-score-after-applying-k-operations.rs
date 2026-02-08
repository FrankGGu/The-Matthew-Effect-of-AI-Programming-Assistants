impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn maximal_score(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums.iter() {
            heap.push(*num);
        }

        let mut score = 0;
        let k = k as usize;

        for _ in 0..k {
            if let Some(max_val) = heap.pop() {
                score += max_val;
                heap.push(max_val / 2);
            }
        }

        score
    }
}

struct Solution {}
}