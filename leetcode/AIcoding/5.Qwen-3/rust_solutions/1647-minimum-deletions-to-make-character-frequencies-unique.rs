impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_deletions(s: String) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut used_freq = std::collections::HashSet::new();
        let mut deletions = 0;

        for (_, &count) in &freq {
            let mut current = count;
            while current > 0 && used_freq.contains(&current) {
                current -= 1;
                deletions += 1;
            }
            if current > 0 {
                used_freq.insert(current);
            }
        }

        deletions
    }
}
}