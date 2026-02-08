impl Solution {

use std::cmp::max;

impl Solution {
    pub fn get_length_of_optimal_subsequence(s: String, k: i32) -> i32 {
        let s = s.chars().collect::<Vec<char>>();
        let n = s.len();
        let mut dp = vec![vec![0; 26]; n];
        let mut prev = vec![vec![-1; 26]; n];

        for i in 0..n {
            for c in 0..26 {
                let ch = (b'a' + c) as char;
                if s[i] == ch {
                    dp[i][c] = 1;
                    prev[i][c] = -1;
                } else {
                    dp[i][c] = 0;
                    prev[i][c] = -1;
                }
            }
        }

        for i in 1..n {
            for j in 0..i {
                for c in 0..26 {
                    if s[j] != s[i] && dp[j][c] > 0 {
                        if dp[i][s[i] as usize - 'a' as usize] < dp[j][c] + 1 {
                            dp[i][s[i] as usize - 'a' as usize] = dp[j][c] + 1;
                            prev[i][s[i] as usize - 'a' as usize] = j as i32;
                        }
                    }
                }
            }
        }

        let mut max_len = 0;
        for i in 0..n {
            for c in 0..26 {
                max_len = max(max_len, dp[i][c]);
            }
        }

        max_len
    }
}
}