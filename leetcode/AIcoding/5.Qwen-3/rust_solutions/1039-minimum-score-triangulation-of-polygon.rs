impl Solution {
    pub fn min_score_triangulation(polygon: Vec<i32>) -> i32 {
        let n = polygon.len();
        let mut dp = vec![vec![0; n]; n];

        for length in 2..n {
            for i in 0..n - length {
                let j = i + length;
                dp[i][j] = std::i32::MAX;
                for k in i + 1..j {
                    let score = dp[i][k] + dp[k][j] + polygon[i] * polygon[k] * polygon[j];
                    dp[i][j] = std::cmp::min(dp[i][j], score);
                }
            }
        }

        dp[0][n - 1]
    }
}