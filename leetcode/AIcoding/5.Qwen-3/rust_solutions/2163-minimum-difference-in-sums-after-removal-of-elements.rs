impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_sum(nums: Vec<i32>, remove_k: i32) -> i64 {
        let k = remove_k as usize;
        let n = nums.len();

        let mut left_min = vec![0; n];
        let mut min_heap = BinaryHeap::new();

        for i in 0..n {
            if i > 0 {
                left_min[i] = left_min[i - 1] + nums[i - 1] as i64;
            }
            min_heap.push(nums[i]);
            if i >= k {
                left_min[i] += *min_heap.peek().unwrap() as i64;
                min_heap.pop();
            }
        }

        let mut right_min = vec![0; n];
        let mut max_heap = BinaryHeap::new();

        for i in (0..n).rev() {
            if i < n - 1 {
                right_min[i] = right_min[i + 1] + nums[i + 1] as i64;
            }
            max_heap.push(nums[i]);
            if i <= n - 1 - k {
                right_min[i] += *max_heap.peek().unwrap() as i64;
                max_heap.pop();
            }
        }

        let mut result = i64::MAX;
        for i in k..n - k {
            result = result.min(left_min[i] + right_min[i]);
        }

        result
    }
}
}