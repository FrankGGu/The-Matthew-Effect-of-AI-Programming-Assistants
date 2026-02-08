impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn number_of_strings(mut s: String, k: i32) -> i32 {
        let mut seen = HashSet::new();
        let mut count = 0;

        for i in 0..s.len() {
            for j in i + 1..=s.len() {
                let substr = &s[i..j];
                if substr.len() > k as usize {
                    break;
                }
                let mut freq = [0; 26];
                for c in substr.chars() {
                    freq[c as usize - 'a' as usize] += 1;
                }
                let mut unique = 0;
                for &f in &freq {
                    if f > 0 {
                        unique += 1;
                    }
                }
                if unique >= k as usize {
                    seen.insert(substr);
                }
            }
        }

        for substr in seen {
            count += 1;
        }

        count
    }
}
}