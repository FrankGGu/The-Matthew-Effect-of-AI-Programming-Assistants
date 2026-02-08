impl Solution {
    pub fn count_house_placements(mut n: i32) -> i32 {
        let mut dp = vec![0; n as usize + 1];
        dp[0] = 1;
        dp[1] = 2;

        for i in 2..=n as usize {
            dp[i] = (dp[i - 1] + dp[i - 2]) % 1000000007;
        }

        (dp[n as usize] * dp[n as usize]) % 1000000007
    }
}