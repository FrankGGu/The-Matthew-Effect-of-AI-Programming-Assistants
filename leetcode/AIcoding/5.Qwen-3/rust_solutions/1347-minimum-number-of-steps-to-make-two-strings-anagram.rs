impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_steps(mut s: String, mut t: String) -> i32 {
        let mut count = HashMap::new();

        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        for c in t.chars() {
            *count.entry(c).or_insert(0) -= 1;
        }

        count.values().filter(|&&v| v > 0).sum()
    }
}
}