impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn minimum_operations_to_make_k_periodic(word: String, k: i32) -> i64 {
        let k = k as usize;
        let mut freq = HashMap::new();
        let n = word.len();
        for i in 0..n / k {
            let start = i * k;
            let end = start + k;
            let substring = &word[start..end];
            *freq.entry(substring).or_insert(0) += 1;
        }
        let max_freq = freq.values().max().copied().unwrap_or(0);
        let total_substrings = n / k;
        (total_substrings as i64 - max_freq) as i64
    }
}
}