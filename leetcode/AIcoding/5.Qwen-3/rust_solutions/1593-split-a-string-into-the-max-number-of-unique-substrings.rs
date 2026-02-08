impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn max_unique_substrings(s: String) -> i32 {
        fn backtrack(s: &str, start: usize, seen: &mut HashSet<String>) -> i32 {
            if start == s.len() {
                return 0;
            }
            let mut max_count = -1;
            for end in start + 1..=s.len() {
                let substr = &s[start..end];
                if !seen.contains(substr) {
                    seen.insert(substr.to_string());
                    let count = backtrack(s, end, seen);
                    if count != -1 {
                        max_count = max_count.max(count + 1);
                    }
                    seen.remove(substr);
                }
            }
            max_count
        }
        let mut seen = HashSet::new();
        backtrack(&s, 0, &mut seen)
    }
}
}