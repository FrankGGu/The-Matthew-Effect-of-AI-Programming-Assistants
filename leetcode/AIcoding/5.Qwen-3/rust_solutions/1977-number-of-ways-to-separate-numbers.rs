impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_ways(mut s: String) -> i64 {
        let n = s.len();
        let mut dp = vec![vec![0; 2]; n + 1];
        dp[0][0] = 1;

        for i in 1..=n {
            let c = s.as_bytes()[i - 1];
            let digit = (c - b'0') as i64;

            for j in 0..i {
                if i - j > 10 {
                    break;
                }

                let num = s[j..i].parse::<i64>().unwrap();

                if num < 10 {
                    dp[i][0] += dp[j][0];
                } else {
                    dp[i][0] += dp[j][0];
                    dp[i][1] += dp[j][1];
                }

                if num >= 10 {
                    dp[i][1] += dp[j][0];
                }
            }
        }

        dp[n][0] + dp[n][1]
    }
}
}