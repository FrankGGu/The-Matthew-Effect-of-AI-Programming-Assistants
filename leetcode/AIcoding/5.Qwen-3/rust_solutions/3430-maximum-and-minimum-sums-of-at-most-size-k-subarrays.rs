impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_and_min_subarray_sums(arr: Vec<i32>, k: i32) -> (i32, i32) {
        let k = k as usize;
        let n = arr.len();
        let mut prefix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + arr[i];
        }

        let mut max_heap = BinaryHeap::new();
        let mut min_heap = BinaryHeap::new();

        for i in 0..n {
            for j in i + 1..=std::cmp::min(i + k, n) {
                let sum = prefix_sum[j] - prefix_sum[i];
                max_heap.push(sum);
                min_heap.push(std::cmp::Reverse(sum));
            }
        }

        let max_sum = *max_heap.peek().unwrap();
        let min_sum = *min_heap.peek().unwrap();

        (max_sum, min_sum)
    }
}
}