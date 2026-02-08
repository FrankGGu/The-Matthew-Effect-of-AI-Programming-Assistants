impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn select_k_disjoint_special_substrings(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut special = HashSet::new();
        let mut positions = vec![];

        for i in 0..n {
            for j in i+1..n {
                if s[i] == s[j] {
                    positions.push((i, j));
                }
            }
        }

        for (i, j) in &positions {
            for l in *i..=*j {
                for r in l..=*j {
                    if s[l] == s[r] {
                        special.insert((l, r));
                    }
                }
            }
        }

        let mut selected = 0;
        let mut used = vec![false; n];

        for (i, j) in &positions {
            if !used[*i] && !used[*j] {
                selected += 1;
                used[*i] = true;
                used[*j] = true;
            }
        }

        if selected >= k {
            return 1;
        } else {
            return 0;
        }
    }
}
}