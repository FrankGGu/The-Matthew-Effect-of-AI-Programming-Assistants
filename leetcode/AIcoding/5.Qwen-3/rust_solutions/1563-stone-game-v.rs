impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn stone_game_v(s: String) -> i32 {
        let s = s.into_bytes();
        let n = s.len();
        let mut dp = vec![vec![0; n]; n];
        let mut sum = vec![0; n + 1];

        for i in 0..n {
            sum[i + 1] = sum[i] + (s[i] as i32);
        }

        for l in 1..n {
            for i in 0..n - l {
                let j = i + l;
                let total = sum[j + 1] - sum[i];
                dp[i][j] = 0;

                for k in i..j {
                    let left = sum[k + 1] - sum[i];
                    let right = total - left;

                    match left.cmp(&right) {
                        Ordering::Less => dp[i][j] = dp[i][j].max(dp[i][k] + left),
                        Ordering::Equal => dp[i][j] = dp[i][j].max(dp[i][k] + left),
                        Ordering::Greater => dp[i][j] = dp[i][j].max(dp[k + 1][j] + right),
                    }
                }
            }
        }

        dp[0][n - 1]
    }
}
}