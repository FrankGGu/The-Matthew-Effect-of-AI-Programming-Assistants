impl Solution {

use std::cmp::min;

impl Solution {
    pub fn count_pyramids(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut result = 0;

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 {
                    dp[i][j] = 1;
                    if i > 0 && j > 0 && j < n - 1 {
                        dp[i][j] = 1 + min(dp[i - 1][j - 1], min(dp[i - 1][j], dp[i - 1][j + 1]));
                    }
                    result += dp[i][j] - 1;
                }
            }
        }

        result
    }
}
}