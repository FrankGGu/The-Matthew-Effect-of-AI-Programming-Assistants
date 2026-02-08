impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_k_diff_pairs(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut result = 0;
        for (&key, _) in &count {
            if k == 0 {
                if count.get(&key).unwrap() >= 2 {
                    result += 1;
                }
            } else {
                if count.contains_key(&(key + k)) {
                    result += 1;
                }
            }
        }

        result
    }
}
}