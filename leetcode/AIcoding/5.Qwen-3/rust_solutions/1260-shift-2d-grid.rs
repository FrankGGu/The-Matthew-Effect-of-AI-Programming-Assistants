struct Solution;

impl Solution {
    pub fn shift_grid(grid: Vec<Vec<i32>>, k: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let total = m * n;
        let k = k as usize % total;

        let mut result = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let original_index = i * n + j;
                let new_index = (original_index + k) % total;
                let new_i = new_index / n;
                let new_j = new_index % n;
                result[new_i][new_j] = grid[i][j];
            }
        }

        result
    }
}