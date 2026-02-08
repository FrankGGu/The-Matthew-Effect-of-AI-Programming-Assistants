impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn answer_queries(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort();
        let mut prefix_sums = vec![0];
        for &num in &nums {
            prefix_sums.push(prefix_sums.last().unwrap() + num);
        }
        let mut result = vec![];
        for q in queries {
            let mut left = 0;
            let mut right = prefix_sums.len() - 1;
            let mut ans = 0;
            while left <= right {
                let mid = (left + right) / 2;
                if prefix_sums[mid] <= q {
                    ans = mid as i32;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            result.push(ans);
        }
        result
    }
}
}