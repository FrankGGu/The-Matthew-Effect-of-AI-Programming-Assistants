impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_k_subsequences_with_max_beauty(s: String, k: i32) -> i32 {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut counts: Vec<_> = freq.values().cloned().collect();
        counts.sort_by(|a, b| b.cmp(a));

        let mut total = 0;
        let mut sum = 0;
        let mut selected = 0;

        for &count in &counts {
            if selected + count >= k {
                let remaining = k - selected;
                let ways = factorial(count) / (factorial(remaining) * factorial(count - remaining));
                total = (total + ways) % 1_000_000_007;
                break;
            } else {
                sum += count;
                selected += count;
            }
        }

        if selected < k {
            return 0;
        }

        total
    }
}

fn factorial(n: i32) -> i32 {
    (1..=n).product()
}
}