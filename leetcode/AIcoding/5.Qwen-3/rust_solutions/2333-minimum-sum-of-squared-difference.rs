impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_sum_squared_degrees(possibility: Vec<i32>, limit: i32) -> i32 {
        let mut max_heap = BinaryHeap::new();
        let mut sum = 0;
        for &p in &possibility {
            sum += p;
            max_heap.push(p);
        }

        while sum > limit {
            let mut current = max_heap.pop().unwrap();
            let decrease = sum - limit;
            let reduce = std::cmp::min(current, decrease);
            current -= reduce;
            sum -= reduce;
            if current > 0 {
                max_heap.push(current);
            }
        }

        let mut result = 0;
        for &p in &possibility {
            result += p * p;
        }
        result
    }
}
}