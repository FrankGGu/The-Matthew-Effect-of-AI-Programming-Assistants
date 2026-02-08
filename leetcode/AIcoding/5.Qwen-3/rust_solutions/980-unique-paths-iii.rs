struct Solution;

impl Solution {
    pub fn unique_paths_with_obstacles(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dp = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    dp[i][j] = 0;
                } else if i == 0 && j == 0 {
                    dp[i][j] = 1;
                } else if i == 0 {
                    dp[i][j] = dp[i][j - 1];
                } else if j == 0 {
                    dp[i][j] = dp[i - 1][j];
                } else {
                    dp[i][j] = dp[i - 1][j] + dp[i][j - 1];
                }
            }
        }

        dp[m - 1][n - 1]
    }
}