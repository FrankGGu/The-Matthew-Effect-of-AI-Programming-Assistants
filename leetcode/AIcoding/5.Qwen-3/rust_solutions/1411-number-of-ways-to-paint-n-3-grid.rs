struct Solution;

impl Solution {
    pub fn num_ways(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut dp = vec![vec![0; 3]; n as usize];
        dp[0][0] = 2;
        dp[0][1] = 2;
        dp[0][2] = 2;
        for i in 1..n as usize {
            dp[i][0] = (dp[i - 1][1] + dp[i - 1][2]) * 2;
            dp[i][1] = (dp[i - 1][0] + dp[i - 1][2]) * 2;
            dp[i][2] = (dp[i - 1][0] + dp[i - 1][1]) * 2;
        }
        dp[n as usize - 1][0] + dp[n as usize - 1][1] + dp[n as usize - 1][2]
    }
}