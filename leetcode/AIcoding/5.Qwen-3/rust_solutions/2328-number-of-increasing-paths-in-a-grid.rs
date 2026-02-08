impl Solution {

use std::cmp::Ordering;
use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn count_paths(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut dp = vec![vec![0; n]; m];
        let mut queue = VecDeque::new();
        let mut in_degree = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let x = i as i32 + dx;
                    let y = j as i32 + dy;
                    if x >= 0 && x < m as i32 && y >= 0 && y < n as i32 {
                        if grid[x as usize][y as usize] < grid[i][j] {
                            in_degree[i][j] += 1;
                        }
                    }
                }
                if in_degree[i][j] == 0 {
                    queue.push_back((i, j));
                    dp[i][j] = 1;
                }
            }
        }

        while let Some((i, j)) = queue.pop_front() {
            for (dx, dy) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                let x = i as i32 + dx;
                let y = j as i32 + dy;
                if x >= 0 && x < m as i32 && y >= 0 && y < n as i32 {
                    if grid[x as usize][y as usize] > grid[i][j] {
                        dp[x as usize][y as usize] += dp[i][j];
                        in_degree[x as usize][y as usize] -= 1;
                        if in_degree[x as usize][y as usize] == 0 {
                            queue.push_back((x as usize, y as usize));
                        }
                    }
                }
            }
        }

        let mut result = 0;
        for i in 0..m {
            for j in 0..n {
                result += dp[i][j];
            }
        }

        result
    }
}
}