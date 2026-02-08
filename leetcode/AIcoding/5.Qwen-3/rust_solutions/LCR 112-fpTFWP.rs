impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut memo = vec![vec![-1; n]; m];
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        fn dfs(matrix: &Vec<Vec<i32>>, memo: &mut Vec<Vec<i32>>, m: usize, n: usize, i: usize, j: usize, directions: &[ (isize, isize); 4 ]) -> i32 {
            if memo[i][j] != -1 {
                return memo[i][j];
            }

            let mut max_path = 1;
            for &(dx, dy) in directions {
                let x = i as isize + dx;
                let y = j as isize + dy;
                if x >= 0 && x < m as isize && y >= 0 && y < n as isize && matrix[x as usize][y as usize] > matrix[i][j] {
                    let path = 1 + dfs(matrix, memo, m, n, x as usize, y as usize, directions);
                    max_path = max_path.max(path);
                }
            }

            memo[i][j] = max_path;
            max_path
        }

        let mut result = 0;
        for i in 0..m {
            for j in 0..n {
                result = result.max(dfs(&matrix, &mut memo, m, n, i, j, &directions));
            }
        }

        result
    }
}
}