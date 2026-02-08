impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_deletions(s: String) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut res = 0;
        let mut used_freq = HashMap::new();

        for (c, count) in freq {
            let mut current = count;
            while current > 0 {
                if !used_freq.contains_key(&current) {
                    used_freq.insert(current, c);
                    break;
                } else {
                    res += 1;
                    current -= 1;
                }
            }
        }

        res
    }
}
}