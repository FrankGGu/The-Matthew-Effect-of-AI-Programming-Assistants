impl Solution {

use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn min_visited_cells(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut row = vec![VecDeque::new(); m];
        let mut col = vec![VecDeque::new(); n];

        for i in 0..m {
            for j in 0..n {
                if i == 0 && j == 0 {
                    dp[i][j] = 1;
                    row[i].push_back(1);
                    col[j].push_back(1);
                    continue;
                }

                let mut min_val = i32::MAX;

                while let Some(&val) = row[i].front() {
                    if val <= j {
                        row[i].pop_front();
                    } else {
                        break;
                    }
                }

                while let Some(&val) = col[j].front() {
                    if val <= i {
                        col[j].pop_front();
                    } else {
                        break;
                    }
                }

                if !row[i].is_empty() {
                    min_val = min_val.min(row[i].front().copied().unwrap());
                }

                if !col[j].is_empty() {
                    min_val = min_val.min(col[j].front().copied().unwrap());
                }

                if min_val != i32::MAX {
                    dp[i][j] = min_val + 1;
                } else {
                    dp[i][j] = 1;
                }

                row[i].push_back(j);
                col[j].push_back(i);
            }
        }

        if dp[m - 1][n - 1] == 0 {
            -1
        } else {
            dp[m - 1][n - 1]
        }
    }
}
}