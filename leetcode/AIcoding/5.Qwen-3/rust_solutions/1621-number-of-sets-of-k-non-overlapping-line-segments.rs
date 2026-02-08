struct Solution;

impl Solution {
    pub fn number_of_sets(k: i32, n: i32) -> i32 {
        let k = k as usize;
        let n = n as usize;
        let mut dp = vec![vec![0; n + 1]; k + 1];

        for i in 0..=n {
            dp[0][i] = 1;
        }

        for i in 1..=k {
            for j in 0..=n {
                dp[i][j] = dp[i][j - 1];
                if j > 0 {
                    dp[i][j] += dp[i - 1][j - 1];
                }
            }
        }

        dp[k][n]
    }
}