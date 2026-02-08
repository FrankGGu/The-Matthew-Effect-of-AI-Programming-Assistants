impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn earl_mean(mut nums: Vec<i32>) -> f64 {
        nums.sort_unstable();
        let n = nums.len();
        let remove = n / 5;
        let start = remove;
        let end = n - remove;
        let sub: Vec<i32> = nums[start..end].to_vec();
        let sum: i64 = sub.iter().map(|&x| x as i64).sum();
        sum as f64 / sub.len() as f64
    }
}
}