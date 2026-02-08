impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut sum = 0;
        for &num in &nums {
            sum += num;
        }
        let target = sum / 2;
        let mut heap = BinaryHeap::new();
        for &num in &nums {
            heap.push(num as f64);
        }
        let mut operations = 0;
        let mut current_sum = sum as f64;
        while current_sum > target as f64 {
            let max = heap.pop().unwrap();
            let half = max / 2.0;
            current_sum -= max - half;
            heap.push(half);
            operations += 1;
        }
        operations
    }
}
}