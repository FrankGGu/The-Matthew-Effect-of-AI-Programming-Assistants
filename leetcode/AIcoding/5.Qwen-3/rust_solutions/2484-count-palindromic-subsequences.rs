struct Solution;

impl Solution {
    pub fn count_palindromic_subsequences(s: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for length in 2..=n {
            for i in 0..(n - length + 1) {
                let j = i + length - 1;
                if s[i] == s[j] {
                    if length == 2 {
                        dp[i][j] = 2;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] * 2 + 2;
                    }
                } else {
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
                }
            }
        }

        dp[0][n - 1]
    }
}