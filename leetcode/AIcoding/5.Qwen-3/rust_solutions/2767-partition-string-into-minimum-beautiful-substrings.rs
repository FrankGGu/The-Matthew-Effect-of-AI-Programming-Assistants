impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn partition(s: String) -> i32 {
        let mut memo = std::collections::HashMap::new();
        Self::dfs(&s, 0, &mut memo)
    }

    fn dfs(s: &str, start: usize, memo: &mut std::collections::HashMap<usize, i32>) -> i32 {
        if start == s.len() {
            return 0;
        }
        if let Some(&res) = memo.get(&start) {
            return res;
        }

        let mut min = i32::MAX;
        for end in start + 1..=s.len() {
            let substr = &s[start..end];
            if is_beautiful(substr) {
                let res = Self::dfs(s, end, memo);
                if res != i32::MAX {
                    min = min.min(1 + res);
                }
            }
        }

        memo.insert(start, min);
        min
    }

    fn is_beautiful(s: &str) -> bool {
        let mut seen = HashSet::new();
        for c in s.chars() {
            if seen.contains(&c) {
                return false;
            }
            seen.insert(c);
        }
        true
    }
}
}