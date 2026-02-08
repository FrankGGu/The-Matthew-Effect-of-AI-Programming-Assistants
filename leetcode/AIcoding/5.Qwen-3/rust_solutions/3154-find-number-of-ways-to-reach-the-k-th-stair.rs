struct Solution {}

impl Solution {
    pub fn number_of_ways(n: i32, k: i32) -> i32 {
        let mut dp = vec![0; k as usize + 1];
        dp[0] = 1;
        for i in 1..=k as usize {
            for j in 1..=n as usize {
                if i >= j {
                    dp[i] += dp[i - j];
                }
            }
        }
        dp[k as usize]
    }
}