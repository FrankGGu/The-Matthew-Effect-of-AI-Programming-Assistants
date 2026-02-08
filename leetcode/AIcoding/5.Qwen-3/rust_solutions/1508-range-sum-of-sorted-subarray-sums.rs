impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

impl Solution {
    pub fn range_sum(nums: Vec<i32>, k: i32, left: i32, right: i32) -> i32 {
        let k = k as usize;
        let left = left as usize;
        let right = right as usize;

        let mut heap = BinaryHeap::new();
        let n = nums.len();

        for i in 0..n {
            let mut sum = 0;
            for j in i..n {
                sum += nums[j];
                if heap.len() < k {
                    heap.push((-sum, j));
                } else if sum < -heap.peek().unwrap().0 {
                    heap.pop();
                    heap.push((-sum, j));
                }
            }
        }

        let mut result = 0;
        let mut temp = Vec::new();

        while let Some((val, _)) = heap.pop() {
            temp.push(-val);
        }

        for i in left - 1..right {
            result += temp[i];
        }

        result
    }
}
}