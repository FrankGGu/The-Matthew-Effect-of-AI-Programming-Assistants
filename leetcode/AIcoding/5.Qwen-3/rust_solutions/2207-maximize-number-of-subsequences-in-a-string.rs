impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_subsequence_count(s: String, word: String) -> i64 {
        let mut count = HashMap::new();
        for c in word.chars() {
            *count.entry(c).or_insert(0) += 1;
        }

        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut result = 1;
        for (c, &need) in &count {
            if let Some(&have) = freq.get(c) {
                result = result.saturating_mul(have / need);
            } else {
                return 0;
            }
        }

        result
    }
}
}