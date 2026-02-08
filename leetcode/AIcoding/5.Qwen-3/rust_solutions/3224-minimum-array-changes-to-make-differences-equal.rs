impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_changes(mut nums: Vec<i32>, n: i32, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut count = HashMap::new();
        for i in 0..n {
            let key = (nums[i] - nums[0]) % k as i32;
            *count.entry(key).or_insert(0) += 1;
        }
        let max_freq = count.values().max().copied().unwrap_or(0);
        (n as i32 - max_freq) as i32
    }
}
}