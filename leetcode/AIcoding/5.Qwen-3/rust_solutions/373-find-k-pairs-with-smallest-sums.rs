impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(PartialEq, Eq)]
struct Pair {
    sum: i32,
    nums1_idx: usize,
    nums2_idx: usize,
}

impl Ord for Pair {
    fn cmp(&self, other: &Self) -> Ordering {
        other.sum.cmp(&self.sum)
    }
}

impl PartialOrd for Pair {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn k_smallest_pairs(nums1: Vec<i32>, nums2: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        let mut heap = BinaryHeap::new();
        let mut result = Vec::new();

        for i in 0..std::cmp::min(nums1.len(), k as usize) {
            heap.push(Pair {
                sum: nums1[i] + nums2[0],
                nums1_idx: i,
                nums2_idx: 0,
            });
        }

        while let Some(pair) = heap.pop() {
            result.push(vec![nums1[pair.nums1_idx], nums2[pair.nums2_idx]]);
            if result.len() == k as usize {
                break;
            }

            let next_idx = pair.nums2_idx + 1;
            if next_idx < nums2.len() {
                heap.push(Pair {
                    sum: nums1[pair.nums1_idx] + nums2[next_idx],
                    nums1_idx: pair.nums1_idx,
                    nums2_idx: next_idx,
                });
            }
        }

        result
    }
}
}