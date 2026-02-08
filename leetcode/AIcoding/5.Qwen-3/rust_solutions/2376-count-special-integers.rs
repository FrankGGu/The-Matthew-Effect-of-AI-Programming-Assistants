impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_special_integers(n: i32) -> i32 {
        let s = n.to_string();
        let mut memo = HashMap::new();
        let mut dp = vec![vec![-1; 2]; s.len()];

        fn dfs(pos: usize, mask: u32, tight: bool, leading_zero: bool, s: &str, memo: &mut HashMap<(usize, u32, bool, bool), i32>, dp: &mut Vec<Vec<i32>>) -> i32 {
            if pos == s.len() {
                return if leading_zero { 0 } else { 1 };
            }

            if !tight && !leading_zero && dp[pos][0] != -1 {
                return dp[pos][0];
            }

            let limit = if tight { s.chars().nth(pos).unwrap().to_digit(10).unwrap() } else { 9 };
            let mut res = 0;

            for d in 0..=limit {
                let new_tight = tight && (d == limit);
                let new_leading_zero = leading_zero && (d == 0);
                let new_mask = if leading_zero && d == 0 {
                    mask
                } else {
                    mask | (1 << d)
                };

                if new_leading_zero {
                    res += dfs(pos + 1, mask, new_tight, true, s, memo, dp);
                } else {
                    res += dfs(pos + 1, new_mask, new_tight, false, s, memo, dp);
                }
            }

            if !tight && !leading_zero {
                dp[pos][0] = res;
            }

            res
        }

        dfs(0, 0, true, true, &s, &mut memo, &mut dp)
    }
}
}