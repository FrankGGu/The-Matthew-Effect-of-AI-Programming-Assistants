struct Solution;

impl Solution {
    pub fn max_increase_keep_skyline(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut row_max = vec![0; rows];
        let mut col_max = vec![0; cols];

        for i in 0..rows {
            for j in 0..cols {
                row_max[i] = row_max[i].max(grid[i][j]);
                col_max[j] = col_max[j].max(grid[i][j]);
            }
        }

        let mut result = 0;
        for i in 0..rows {
            for j in 0..cols {
                result += row_max[i].min(col_max[j]) - grid[i][j];
            }
        }

        result
    }
}