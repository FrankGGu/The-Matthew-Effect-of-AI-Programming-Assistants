impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn distinct_averages(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let mut seen = HashSet::new();
        let n = nums.len();
        for i in 0..n / 2 {
            let avg = (nums[i] + nums[n - 1 - i]) as f64 / 2.0;
            seen.insert(avg);
        }
        seen.len() as i32
    }
}
}