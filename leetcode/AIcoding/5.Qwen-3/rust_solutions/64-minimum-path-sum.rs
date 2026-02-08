impl Solution {

use std::cmp;

impl Solution {
    pub fn min_path_sum(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let mut dp = grid;

        for i in 1..m {
            dp[i][0] += dp[i - 1][0];
        }

        for j in 1..n {
            dp[0][j] += dp[0][j - 1];
        }

        for i in 1..m {
            for j in 1..n {
                dp[i][j] += cmp::min(dp[i - 1][j], dp[i][j - 1]);
            }
        }

        dp[m - 1][n - 1]
    }
}
}