impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn k_sum(mut nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut max_heap = BinaryHeap::new();
        let mut sum = 0;

        for num in &mut nums {
            if *num < 0 {
                *num = -(*num);
                sum -= *num;
            } else {
                sum += *num;
            }
        }

        nums.sort();

        max_heap.push((sum, 0));

        for _ in 0..k - 1 {
            if max_heap.is_empty() {
                return 0;
            }
            let (current_sum, index) = max_heap.pop().unwrap();
            if index >= nums.len() {
                continue;
            }
            let next_index = index + 1;
            let next_sum = current_sum - nums[index];
            max_heap.push((next_sum, next_index));
            if next_index < nums.len() {
                let next_next_sum = current_sum - 2 * nums[index];
                max_heap.push((next_next_sum, next_index));
            }
        }

        max_heap.pop().unwrap().0
    }
}
}