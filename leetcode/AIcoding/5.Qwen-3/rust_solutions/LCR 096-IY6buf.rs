struct Solution;

impl Solution {
    pub fn is_interleave(s1: String, s2: String, s3: String) -> bool {
        if s1.len() + s2.len() != s3.len() {
            return false;
        }

        let m = s1.len();
        let n = s2.len();
        let mut dp = vec![vec![false; n + 1]; m + 1];
        dp[0][0] = true;

        for i in 0..=m {
            for j in 0..=n {
                if i == 0 && j == 0 {
                    continue;
                }
                let mut valid = false;
                if i > 0 {
                    valid |= dp[i - 1][j] && s1.chars().nth(i - 1) == s3.chars().nth(i + j - 1);
                }
                if j > 0 {
                    valid |= dp[i][j - 1] && s2.chars().nth(j - 1) == s3.chars().nth(i + j - 1);
                }
                dp[i][j] = valid;
            }
        }

        dp[m][n]
    }
}