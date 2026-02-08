impl Solution {

use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn max_number_of_non_intersecting_substrings(s: String) -> i32 {
        let mut map = HashMap::new();
        let s_bytes = s.as_bytes();
        let n = s.len();

        for i in 0..n {
            for j in i + 1..n {
                if s_bytes[i] == s_bytes[j] {
                    map.entry(i).or_insert_with(HashSet::new).insert(j);
                }
            }
        }

        let mut dp = vec![0; n];
        let mut max_count = 0;

        for i in 0..n {
            dp[i] = 1;
            for j in 0..i {
                if !map.get(&j).unwrap_or(&HashSet::new()).contains(&i) {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
            max_count = max_count.max(dp[i]);
        }

        max_count
    }
}
}