impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_pushes(strs: String) -> i32 {
        let mut freq = HashMap::new();
        for c in strs.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_by(|a, b| b.cmp(a));

        let mut res = 0;
        for (i, &count) in counts.iter().enumerate() {
            res += count * ((i / 8) + 1) as i32;
        }

        res
    }
}
}