impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn rearrange_characters(s: String, target: String) -> i32 {
        let mut s_count = HashMap::new();
        let mut target_count = HashMap::new();

        for c in s.chars() {
            *s_count.entry(c).or_insert(0) += 1;
        }

        for c in target.chars() {
            *target_count.entry(c).or_insert(0) += 1;
        }

        let mut min_possible = i32::MAX;

        for (c, &count) in &target_count {
            if let Some(&s_count) = s_count.get(c) {
                let possible = s_count / count;
                min_possible = std::cmp::min(min_possible, possible);
            } else {
                return 0;
            }
        }

        min_possible
    }
}
}