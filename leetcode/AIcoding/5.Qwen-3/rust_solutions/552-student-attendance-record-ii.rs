struct Solution;

impl Solution {
    pub fn check_record(n: i32) -> i32 {
        const MOD: i32 = 1000000007;
        let mut dp = vec![vec![0; 2]; 3];
        dp[0][0] = 1;
        dp[0][1] = 1;

        for _ in 1..n {
            let mut new_dp = vec![vec![0; 2]; 3];
            for a in 0..3 {
                for l in 0..2 {
                    if a == 0 {
                        new_dp[a][l] = (new_dp[a][l] + dp[a][l]) % MOD;
                    }
                    if l < 1 {
                        new_dp[a][l + 1] = (new_dp[a][l + 1] + dp[a][l]) % MOD;
                    }
                    if a < 2 {
                        new_dp[a + 1][0] = (new_dp[a + 1][0] + dp[a][l]) % MOD;
                    }
                }
            }
            dp = new_dp;
        }

        let mut result = 0;
        for a in 0..3 {
            for l in 0..2 {
                result = (result + dp[a][l]) % MOD;
            }
        }
        result
    }
}