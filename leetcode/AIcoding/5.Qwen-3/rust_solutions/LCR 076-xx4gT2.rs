impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn find_kth_max(nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }
        let mut result = 0;
        for _ in 0..k {
            if let Some(val) = heap.pop() {
                result = val;
            }
        }
        result
    }
}
}