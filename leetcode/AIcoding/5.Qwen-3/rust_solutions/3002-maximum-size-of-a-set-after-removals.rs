impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn maximum_size_after_removals(mut nums: Vec<i32>, m: i32) -> i32 {
        let mut freq = std::collections::HashMap::new();
        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        let mut counts: Vec<_> = freq.into_values().collect();
        counts.sort_by(|a, b| b.cmp(a));

        let mut total = 0;
        let mut removed = 0;
        let mut unique = 0;

        for &count in &counts {
            if removed < m {
                let to_remove = std::cmp::min(count, m - removed);
                removed += to_remove;
                total += count - to_remove;
                unique += 1;
            } else {
                total += count;
                unique += 1;
            }
        }

        unique.min(total)
    }
}
}