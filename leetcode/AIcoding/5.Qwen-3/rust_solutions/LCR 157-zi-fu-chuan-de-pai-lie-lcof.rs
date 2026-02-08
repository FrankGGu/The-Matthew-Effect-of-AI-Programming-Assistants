impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_pairs(n: i32, nums: Vec<i32>) -> i32 {
        let mut freq = HashMap::new();
        let mut result = 0;

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for (key, &count) in &freq {
            if *key == 0 {
                continue;
            }
            let complement = n - key;
            if let Some(&complement_count) = freq.get(&complement) {
                result += count * complement_count;
            }
        }

        result / 2
    }
}
}