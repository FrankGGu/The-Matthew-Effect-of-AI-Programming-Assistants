impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_subsequence(mut nums: Vec<i32>) -> Vec<i32> {
        let sum: i32 = nums.iter().sum();
        let mut heap = BinaryHeap::new();
        for num in nums.iter() {
            heap.push(Reverse(*num));
        }
        let mut result = Vec::new();
        let mut current_sum = 0;
        while let Some(Reverse(num)) = heap.pop() {
            result.push(num);
            current_sum += num;
            if current_sum > sum - current_sum {
                break;
            }
        }
        result
    }
}
}