impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn kth_largest_xor(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut prefix_xor = vec![0; n + 1];

        for i in 0..n {
            prefix_xor[i + 1] = prefix_xor[i] ^ nums[i];
        }

        let mut max_heap = BinaryHeap::new();

        for i in 0..n {
            for j in i + 1..n + 1 {
                let xor_val = prefix_xor[j] ^ prefix_xor[i];
                max_heap.push(Reverse(xor_val));
                if max_heap.len() > k as usize {
                    max_heap.pop();
                }
            }
        }

        max_heap.pop().unwrap().0
    }
}
}