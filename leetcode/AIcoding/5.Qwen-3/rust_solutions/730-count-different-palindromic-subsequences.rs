struct Solution;

impl Solution {
    pub fn count_palindromic_subseq(s: String) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut dp = vec![vec![0; n]; n];

        for i in 0..n {
            dp[i][i] = 1;
        }

        for len in 2..=n {
            for i in 0..n - len + 1 {
                let j = i + len - 1;
                if s[i] == s[j] {
                    if len == 2 {
                        dp[i][j] = 2;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] * 2;
                    }
                } else {
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
                }
            }
        }

        dp[0][n - 1]
    }
}