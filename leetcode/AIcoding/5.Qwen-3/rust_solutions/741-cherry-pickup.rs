impl Solution {

use std::cmp::max;

impl Solution {
    pub fn cherry_pickup(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut dp = vec![vec![-1; n]; n];
        dp[0][0] = grid[0][0];

        for k in 1..2 * n - 1 {
            let mut next_dp = vec![vec![-1; n]; n];
            for x1 in 0..n {
                for y1 in 0..n {
                    let x2 = k - x1;
                    let y2 = k - y1;
                    if x2 >= n || y2 >= n || x2 < 0 || y2 < 0 {
                        continue;
                    }
                    if grid[x1][y1] == -1 || grid[x2][y2] == -1 {
                        continue;
                    }
                    let mut curr = dp[x1][y1];
                    if curr == -1 {
                        continue;
                    }
                    if x1 == x2 && y1 == y2 {
                        next_dp[x1][y1] = max(next_dp[x1][y1], curr + grid[x2][y2]);
                    } else {
                        next_dp[x1][y1] = max(next_dp[x1][y1], curr + grid[x2][y2]);
                    }
                    for dx in [-1, 0] {
                        for dy in [-1, 0] {
                            let nx1 = x1 + dx;
                            let ny1 = y1 + dy;
                            if nx1 >= 0 && ny1 >= 0 {
                                next_dp[x1][y1] = max(next_dp[x1][y1], dp[nx1][ny1]);
                            }
                        }
                    }
                }
            }
            dp = next_dp;
        }

        if dp[n-1][n-1] < 0 {
            0
        } else {
            dp[n-1][n-1]
        }
    }
}
}