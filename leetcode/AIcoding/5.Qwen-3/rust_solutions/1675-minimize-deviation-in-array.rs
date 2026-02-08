impl Solution {

use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn minimum_deviation(mut nums: Vec<i32>) -> i32 {
        let mut max_heap = BinaryHeap::new();
        let mut min_val = i32::MAX;

        for num in &mut nums {
            if num % 2 == 1 {
                *num *= 2;
            }
            max_heap.push(*num);
            min_val = std::cmp::min(min_val, *num);
        }

        let mut result = i32::MAX;

        while let Some(current) = max_heap.pop() {
            result = std::cmp::min(result, current - min_val);

            if current % 2 == 0 {
                let next = current / 2;
                max_heap.push(next);
                min_val = std::cmp::min(min_val, next);
            } else {
                break;
            }
        }

        result
    }
}
}