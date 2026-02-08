impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn prefix_suffix_match(nums: Vec<String>) -> i32 {
        let mut count = 0;
        let mut map = HashMap::new();

        for s in nums.iter() {
            for i in 0..=s.len() {
                let prefix = &s[..i];
                let suffix = &s[i..];
                if prefix == suffix {
                    *map.entry(prefix).or_insert(0) += 1;
                }
            }
        }

        for v in map.values() {
            count += v * (v - 1) / 2;
        }

        count
    }
}
}