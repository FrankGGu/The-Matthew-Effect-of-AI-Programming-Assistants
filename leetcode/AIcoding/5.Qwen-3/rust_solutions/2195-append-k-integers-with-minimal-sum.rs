impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_sum(mut nums: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let mut heap = BinaryHeap::new();

        for num in nums.iter() {
            heap.push(*num);
        }

        for _ in 0..k {
            let mut current = heap.pop().unwrap();
            current += 1;
            heap.push(current);
        }

        let mut sum = 0;
        while let Some(num) = heap.pop() {
            sum += num as i64;
        }

        sum
    }
}
}