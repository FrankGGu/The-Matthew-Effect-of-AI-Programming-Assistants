struct Solution {}

impl Solution {
    pub fn minimum_total(triangle: Vec<Vec<i32>>) -> i32 {
        let mut dp = triangle.clone();
        for i in (0..dp.len() - 1).rev() {
            for j in 0..dp[i].len() {
                dp[i][j] += dp[i + 1][j].min(dp[i + 1][j + 1]);
            }
        }
        dp[0][0]
    }
}