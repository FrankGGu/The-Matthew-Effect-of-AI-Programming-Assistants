impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn is_palindrome(s: &str, l: usize, r: usize) -> bool {
        let s_bytes = s.as_bytes();
        while l < r {
            if s_bytes[l] != s_bytes[r] {
                return false;
            }
            l += 1;
            r -= 1;
        }
        true
    }

    pub fn check_partitioning(s: &str) -> bool {
        let n = s.len();
        let mut dp = vec![vec![false; n]; n];

        for i in 0..n {
            dp[i][i] = true;
        }

        for l in 1..n {
            for i in 0..n - l {
                let j = i + l;
                if s.as_bytes()[i] == s.as_bytes()[j] && (l == 1 || dp[i + 1][j - 1]) {
                    dp[i][j] = true;
                }
            }
        }

        for i in 0..n {
            for j in i..n {
                if dp[0][i] && dp[i + 1][j] && dp[j + 1][n - 1] {
                    return true;
                }
            }
        }

        false
    }
}

pub struct Solution;
}