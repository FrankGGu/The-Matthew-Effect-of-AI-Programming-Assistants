impl Solution {

use std::cmp::max;

impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![vec![-1; n]; n]; m];

        fn dfs(grid: &Vec<Vec<i32>>, dp: &mut Vec<Vec<Vec<i32>>>, m: usize, n: usize, row: usize, col1: usize, col2: usize) -> i32 {
            if row == m {
                return 0;
            }
            if dp[row][col1][col2] != -1 {
                return dp[row][col1][col2];
            }

            let mut res = 0;
            for d1 in [-1, 0, 1] {
                for d2 in [-1, 0, 1] {
                    let new_col1 = col1 as i32 + d1;
                    let new_col2 = col2 as i32 + d2;
                    if new_col1 >= 0 && new_col1 < n as i32 && new_col2 >= 0 && new_col2 < n as i32 {
                        res = max(res, dfs(grid, dp, m, n, row + 1, new_col1 as usize, new_col2 as usize));
                    }
                }
            }

            let curr_cherries = if col1 == col2 {
                grid[row][col1]
            } else {
                grid[row][col1] + grid[row][col2]
            };

            dp[row][col1][col2] = curr_cherries + res;
            dp[row][col1][col2]
        }

        dfs(&grid, &mut dp, m, n, 0, 0, n - 1)
    }
}
}