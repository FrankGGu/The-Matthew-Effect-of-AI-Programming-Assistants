impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn rotate_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let mut result = grid.clone();
        let mut queue = VecDeque::new();

        for i in 0..m {
            for j in 0..n {
                queue.push_back((i, j));
            }
        }

        let k = k as usize;
        let total = m * n;
        let k = k % total;

        for _ in 0..k {
            let (i, j) = queue.pop_front().unwrap();
            let val = result[i][j];
            queue.push_back((i, j));
            let (ni, nj) = if j + 1 < n { (i, j + 1) } else if i + 1 < m { (i + 1, j) } else if j > 0 { (i, j - 1) } else { (i - 1, j) };
            result[ni][nj] = val;
        }

        result
    }
}
}