impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_unique_substrings(p: String) -> i32 {
        let mut dp = HashMap::new();
        let mut prev = 0;
        for (i, c) in p.chars().enumerate() {
            if i > 0 && (c as u8 - p.chars().nth(i - 1).unwrap() as u8) == 1 {
                prev += 1;
            } else {
                prev = 1;
            }
            *dp.entry(c).or_insert(0) = std::cmp::max(*dp.get(&c).unwrap_or(&0), prev);
        }
        dp.values().sum::<i32>()
    }
}

struct Solution;
}