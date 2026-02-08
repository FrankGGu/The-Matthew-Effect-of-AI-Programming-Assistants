impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_symmetric_integers(num: i32) -> i32 {
        let mut count = 0;
        for i in 1..=num {
            let s = i.to_string();
            if s.len() % 2 != 0 {
                continue;
            }
            let half = s.len() / 2;
            let left = &s[..half];
            let right = &s[half..];
            let mut map = HashMap::new();
            for c in left.chars() {
                *map.entry(c).or_insert(0) += 1;
            }
            for c in right.chars() {
                *map.entry(c).or_insert(0) -= 1;
            }
            if map.values().all(|&v| v == 0) {
                count += 1;
            }
        }
        count
    }
}
}