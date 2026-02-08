impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut freq = HashMap::new();
        let mut result = 0;

        for num in nums.iter_mut() {
            let rem = (*num % k + k) % k;
            let complement = (k - rem) % k;
            result += *freq.get(&complement).unwrap_or(&0);
            *freq.entry(rem).or_insert(0) += 1;
        }

        result
    }
}
}