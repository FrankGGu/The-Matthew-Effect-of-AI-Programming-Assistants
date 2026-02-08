impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn max_score(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let mut pairs = nums1.iter().zip(nums2.iter()).map(|(&a, &b)| (b, a)).collect::<Vec<_>>();
        pairs.sort_by_key(|&x| Reverse(x.0));

        let mut min_heap = BinaryHeap::new();
        let mut sum = 0;
        let mut max_score = i64::MIN;

        for (val2, val1) in pairs {
            sum += val1 as i64;
            min_heap.push(val1);

            if min_heap.len() > k {
                sum -= *min_heap.pop().unwrap() as i64;
            }

            if min_heap.len() == k {
                max_score = max_score.max(sum * val2 as i64);
            }
        }

        max_score
    }
}
}