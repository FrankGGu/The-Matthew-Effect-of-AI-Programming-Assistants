impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn min_deletion_rows(mut grid: Vec<Vec<char>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![1; n];

        for j in 0..n {
            for i in 1..m {
                if grid[i][j] >= grid[i-1][j] {
                    continue;
                } else {
                    break;
                }
            }
            for j2 in j+1..n {
                let mut valid = true;
                for i in 1..m {
                    if grid[i][j] > grid[i][j2] {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    dp[j2] = dp[j2].max(dp[j] + 1);
                }
            }
        }

        *dp.iter().max().unwrap()
    }
}
}