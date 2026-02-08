impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn largest_perimeter(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable_by(|a, b| b.cmp(a));
        let mut sum = 0;
        for &num in &nums {
            sum += num;
        }
        for i in 1..nums.len() {
            if sum - nums[i] > nums[i] {
                return sum;
            }
            sum -= nums[i];
        }
        -1
    }
}
}