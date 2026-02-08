struct Solution;

impl Solution {
    pub fn find_ball(grid: Vec<Vec<i32>>) -> Vec<i32> {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut result = vec![0; cols];

        for col in 0..cols {
            let mut current_col = col;
            for row in 0..rows {
                let next_col = current_col + grid[row][current_col] as usize;
                if next_col < 0 || next_col >= cols {
                    current_col = -1;
                    break;
                }
                if grid[row][current_col] != grid[row][next_col] {
                    current_col = -1;
                    break;
                }
                current_col = next_col;
            }
            result[col] = current_col;
        }

        result
    }
}