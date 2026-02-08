impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_ways(s: String, k: i32) -> i32 {
        let n = s.len();
        let mut dp = vec![vec![0; k as usize + 1]; n];
        let mut prefix = vec![0; n];

        for i in 0..n {
            if i > 0 {
                prefix[i] = prefix[i - 1];
            }
            if s.as_bytes()[i] == b'1' {
                prefix[i] += 1;
            }
        }

        for i in 0..n {
            if s.as_bytes()[i] == b'1' {
                dp[i][0] = 1;
            }
        }

        for j in 1..k as usize {
            for i in 0..n {
                if s.as_bytes()[i] == b'1' {
                    for prev in 0..i {
                        if s.as_bytes()[prev] == b'1' {
                            dp[i][j] += dp[prev][j - 1];
                        }
                    }
                }
            }
        }

        let mut res = 0;
        for i in 0..n {
            if s.as_bytes()[i] == b'1' {
                res += dp[i][k as usize - 1];
            }
        }

        res
    }
}
}